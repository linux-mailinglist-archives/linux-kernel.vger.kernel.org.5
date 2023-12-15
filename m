Return-Path: <linux-kernel+bounces-478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E48141C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A53E1F22EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592A9C8F5;
	Fri, 15 Dec 2023 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CDRG6j6/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5147470
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DaBm7yNqDy80Knldoq2N90xqNJQZ4RvVwAdVo/hC8ZM=; b=CDRG6j6/xIjPgvJvv8YcjQv1wg
	RJYgnUg8FHAw2xne5lp8nzMED/5RwO2cAyJg6uRZ2iR2INWXRiaK4kydsmHdeEKb8a3ZA+8dwIFwK
	iHTqepcy4yDVbl3WpjMeltbBLjVO3JzS+YBX3FEllrnUWGtSivj0Z4AcDLjhbRu5BV4pVLk6JewRa
	zLrhDwg4NWUmup7Ikyd3zxdnuQp1ySJYJ9kl/vdRCRoCws9atX7OLzmve3NuXx+KAp0e/0bA0A44W
	l8Ft4ZARKrXrZmiJAFRJcqnPuQwZrZygOuGqmvsXvCGBMq2GWqUx5hxwWdy25Ts3KLbXCVe74nbbb
	deUpjOlw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE1ZO-002ApI-0X;
	Fri, 15 Dec 2023 06:21:10 +0000
Message-ID: <e9b028b3-20e6-4e74-a305-c4f18efc70e1@infradead.org>
Date: Thu, 14 Dec 2023 22:21:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drivers: gpu: drm: vmwgfx: fixed typos
Content-Language: en-US
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, zackr@vmware.com,
 linux-graphics-maintainer@vmware.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231215060159.555229-1-ghanshyam1898@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215060159.555229-1-ghanshyam1898@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/14/23 22:01, Ghanshyam Agrawal wrote:
> Fixed multiple typos in vmwgfx_execbuf.c
> 
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
> V2:
> Fixed some more typos suggested by codespell
> and the community.
> 
> V1:
> Fixed multiple typos
> 
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 36987ef3fc30..76aa72e8be73 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -127,7 +127,7 @@ struct vmw_ctx_validation_info {
>   * @func: Call-back to handle the command.
>   * @user_allow: Whether allowed from the execbuf ioctl.
>   * @gb_disable: Whether disabled if guest-backed objects are available.
> - * @gb_enable: Whether enabled iff guest-backed objects are available.
> + * @gb_enable: Whether enabled if guest-backed objects are available.

"iff" normally means "if and only if" and its use in the kernel sources is
usually not a mistake. However, this one sounds dodgy to me (before your change),
so it's OK IMO. Also, the line above it uses "if" for a similar comment.

Maybe someone else knows better.

>   * @cmd_name: Name of the command.
>   */
>  struct vmw_cmd_entry {
> @@ -621,10 +621,10 @@ static int vmw_resources_reserve(struct vmw_sw_context *sw_context)
>   * @sw_context: Pointer to the software context.
>   * @res_type: Resource type.
>   * @dirty: Whether to change dirty status.
> - * @converter: User-space visisble type specific information.
> + * @converter: User-space visible type specific information.
>   * @id_loc: Pointer to the location in the command buffer currently being parsed
>   * from where the user-space resource id handle is located.
> - * @p_res: Pointer to pointer to resource validalidation node. Populated on
> + * @p_res: Pointer to pointer to resource validation node. Populated on
>   * exit.
>   */
>  static int
> @@ -1069,7 +1069,7 @@ static int vmw_query_bo_switch_prepare(struct vmw_private *dev_priv,
>   * object following that query wait has signaled, we are sure that all preceding
>   * queries have finished, and the old query buffer can be unpinned. However,
>   * since both the new query buffer and the old one are fenced with that fence,
> - * we can do an asynchronus unpin now, and be sure that the old query buffer
> + * we can do an asynchronous unpin now, and be sure that the old query buffer
>   * won't be moved until the fence has signaled.
>   *
>   * As mentioned above, both the new - and old query buffers need to be fenced

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

