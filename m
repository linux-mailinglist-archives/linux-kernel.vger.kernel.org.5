Return-Path: <linux-kernel+bounces-19104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA2826814
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D198D28145E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAA79E0;
	Mon,  8 Jan 2024 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zgRQChGh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66379DC;
	Mon,  8 Jan 2024 06:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24915C433C8;
	Mon,  8 Jan 2024 06:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704695988;
	bh=nHahIKG1B+hbq6S6EJafO53DOY81FU14NqxbHiUl0qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zgRQChGhcR50eyy9G2qGMn1k+uozQgySgx6t1LFBzrXM521RSuYNkN5EF7qJiOCaW
	 SGwyxaQbkhQghIKgB+ruFW2Xh39MabeEoNRzKZtE1AqD7WEfJlOkcKMPAEOXId3gr0
	 aQVug0UtbDrbrnxlqyT3XlKDqpzs116V8EgsH6aE=
Date: Mon, 8 Jan 2024 07:39:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Yee <mgyee9@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fixed check alignment of open
 parenthesis in card.c
Message-ID: <2024010822-unplug-pacifist-9791@gregkh>
References: <20240108060207.92348-1-mgyee9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108060207.92348-1-mgyee9@gmail.com>

On Sun, Jan 07, 2024 at 10:02:07PM -0800, Matthias Yee wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Matthias Yee <mgyee9@gmail.com>
> ---
>  drivers/staging/vt6655/card.c | 74 +++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

