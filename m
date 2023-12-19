Return-Path: <linux-kernel+bounces-5498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C6818B64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E188D1F22D89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDEF1CFA0;
	Tue, 19 Dec 2023 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1RhiD+jZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD161F605;
	Tue, 19 Dec 2023 15:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24CDC433C9;
	Tue, 19 Dec 2023 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703000407;
	bh=grP01wEzHEY+P/AJ9wJUOp8gbbINY7i13UDZOkqesUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1RhiD+jZRugrX9VCLGwWP8amkkRhLqBy5p2OYJNc+dAQ44uB7tKDmQufzjF6jcRxw
	 YpK3vfXV472R8IprTBexPp2dj6B6pyU/TavFBsobw+skbZGziCu9nEs5br+Aix6ob/
	 tAIOOFyBvt5aJKh+ctQ9h9bVwguELn9Zl7Azh/NU=
Date: Tue, 19 Dec 2023 16:40:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 2/3] kobject: Improve a size determination in
 kobject_uevent_env()
Message-ID: <2023121946-immovable-striving-e2c7@gregkh>
References: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
 <f007f92c-a355-4bb9-a715-aa42ee6c647b@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f007f92c-a355-4bb9-a715-aa42ee6c647b@web.de>

On Tue, Dec 19, 2023 at 04:34:19PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 19 Dec 2023 16:00:22 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Sorry, but for obvious reasons, I'm still not taking patches from you.

best of luck,

greg k-h

