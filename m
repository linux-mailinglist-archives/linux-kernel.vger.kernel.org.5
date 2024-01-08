Return-Path: <linux-kernel+bounces-19133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FD4826880
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EA91F21C41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72F8BEB;
	Mon,  8 Jan 2024 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbwlLN2g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEF8BF3;
	Mon,  8 Jan 2024 07:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513E4C433C7;
	Mon,  8 Jan 2024 07:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704698563;
	bh=Li6NgH53kCBdKGnmwy4LJKSLzH4Ck/rXJVwrtE6DCc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbwlLN2gSOP4NiCpLT4z4sv6NrKsagBN4Oz+AyH5UUB4Q+K25fOuBgxTsp64p+q9D
	 y3a6gN0k3cXItXOWOdau8cv8OjcD3lzwFWIvcogX0MuYABKRTcAImyQ39TbmqanpIw
	 DFzz2S3Rb1d2MBLZ5tnBwCyIgfeghMcIzHTJDf6g=
Date: Mon, 8 Jan 2024 08:22:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Yee <mgyee9@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: fixed check alignment of open
 parenthesis in card.c
Message-ID: <2024010821-nineteen-unlawful-5105@gregkh>
References: <20240108070310.2942-1-mgyee9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108070310.2942-1-mgyee9@gmail.com>

On Sun, Jan 07, 2024 at 11:03:10PM -0800, Matthias Yee wrote:
> Adjusted whitespace to fix checkpatch warning Alignment Should Match
> Open Paranthesis.
> 
> Signed-off-by: Matthias Yee <mgyee9@gmail.com>
> ---
>  drivers/staging/vt6655/card.c | 74 +++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

