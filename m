Return-Path: <linux-kernel+bounces-10316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF381D2A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170D2283DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F763C7;
	Sat, 23 Dec 2023 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDeIrQ/x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BBF5381;
	Sat, 23 Dec 2023 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4JL4jEzhUoNsA3Zf36XE7Q8KtfPB+mWRBIWTPeF9M50=; b=SDeIrQ/xS7bSkDOGH8GjvxUAN4
	wQXyJbTGprQzWPOXUsRcAtzXrpLy9NerJoQvYIB3ztzkNMv0442PNEyPaLdL+yKxWCB25YcAwTTd4
	2naqgTn2HcJ5KNgH30l4A4I8/8q8tvb5CyE/hWAWgWI+62VJdkgI8mrg6esMlqapyl3o1W9aW6pwu
	vYqqI9b4t2AoWsD5n4oWxm4gu3BopW/H0DK3FNWWLmMqLRzcluUCHyhG/yMdl57f5WLuK96RHGgWy
	cv3+5IFjJLUJL3GdZHBdWenS7veMDsmlMbRPBEsTGlDXaFUng3n95ElcA7Jfeua5SUbcNQ6FIANP8
	1qi8+6oQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGvLY-007S9v-1Y;
	Sat, 23 Dec 2023 06:18:52 +0000
Message-ID: <0717ebb1-851b-4fca-a761-c0aa2b17f751@infradead.org>
Date: Fri, 22 Dec 2023 22:18:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media/atomisp/pci/base/circbuf/src: Fix spelling
 mistakes in circbuf.c
Content-Language: en-US
To: Dipendra Khadka <kdipendra88@gmail.com>, hdegoede@redhat.com,
 mchehab@kernel.org, sakari.ailus@linux.intel.com,
 gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223060422.77789-1-kdipendra88@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223060422.77789-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/23 22:04, Dipendra Khadka wrote:
> codespell reported following spelling mistakes
> in circbuf.c as below:
> 
> '''
> ./circbuf.c:27: whehter ==> whether
> ./circbuf.c:132: offest ==> offset
> '''
> This patch fixes these spelling mistakes.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c b/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
> index d9f7c143794d..2f484ef9d4b5 100644
> --- a/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
> +++ b/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
> @@ -24,7 +24,7 @@
>   **********************************************************************/
>  /*
>   * @brief Read the oldest element from the circular buffer.
> - * Read the oldest element WITHOUT checking whehter the
> + * Read the oldest element WITHOUT checking whether the
>   * circular buffer is empty or not. The oldest element is
>   * also removed out from the circular buffer.
>   *
> @@ -129,7 +129,7 @@ uint32_t ia_css_circbuf_extract(ia_css_circbuf_t *cb, int offset)
>  	u32 src_pos;
>  	u32 dest_pos;
>  
> -	/* get the maximum offest */
> +	/* get the maximum offset */
>  	max_offset = ia_css_circbuf_get_offset(cb, cb->desc->start, cb->desc->end);
>  	max_offset--;
>  

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

