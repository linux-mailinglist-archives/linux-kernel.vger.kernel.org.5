Return-Path: <linux-kernel+bounces-13458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1728206E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BE1B2110A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E19945A;
	Sat, 30 Dec 2023 15:39:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05C8F5C;
	Sat, 30 Dec 2023 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rJacG-0004OZ-00; Sat, 30 Dec 2023 15:47:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 3DD4EC0A5A; Sat, 30 Dec 2023 15:45:45 +0100 (CET)
Date: Sat, 30 Dec 2023 15:45:45 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: Remove unused shadow GPR support from vector
 irq setup
Message-ID: <ZZAtGYY89SrffYBQ@alpha.franken.de>
References: <20231221125405.229100-1-tsbogend@alpha.franken.de>
 <20231221125405.229100-2-tsbogend@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221125405.229100-2-tsbogend@alpha.franken.de>

On Thu, Dec 21, 2023 at 01:54:04PM +0100, Thomas Bogendoerfer wrote:
> Using shadow GPRs for vectored interrupts has never been used,
> time to remove it.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/kernel/traps.c | 94 +++++++++++++---------------------------
>  1 file changed, 30 insertions(+), 64 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

