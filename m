Return-Path: <linux-kernel+bounces-8227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F481B400
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FA428300D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9636EB64;
	Thu, 21 Dec 2023 10:41:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72A745C7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5d1l6lz4xPQ;
	Thu, 21 Dec 2023 21:40:53 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, oss@buserror.net, christophe.leroy@csgroup.eu
In-Reply-To: <20231205051239.737384-1-mpe@ellerman.id.au>
References: <20231205051239.737384-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: powerpc: Transfer PPC83XX to Christophe
Message-Id: <170315510011.2192823.14998930570584611588.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 05 Dec 2023 16:12:39 +1100, Michael Ellerman wrote:
> Christophe volunteered[1] to maintain PPC83XX.
> 
> 1: https://lore.kernel.org/all/7b1bf4dc-d09d-35b8-f4df-16bf00429b6d@csgroup.eu/
> 
> 

Applied to powerpc/next.

[1/1] MAINTAINERS: powerpc: Transfer PPC83XX to Christophe
      https://git.kernel.org/powerpc/c/4cb3e3ec23fa33a0f58ff133d5aedd26a50356ef

cheers

