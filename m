Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931E7C5D94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376305AbjJKTVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjJKTVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:21:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B544690
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=esaMI3DfxyUr+uOWQaByS2QpbSkEsN0pCUovNdYJwII=; b=lpcUonOoRAKpTj+YYpaBDUrSRg
        Eh48JF+U9dz/XM8BGXDlCE0SKZZ74idRtToajQ0MQ2Gux+nQhACuwnxF83EPHA7SqHJdwXUqT4eEd
        7B0zd7EiMHU7f2Z+666wKWz3GFtcyBZAfe9Efdid6tQT0hQxfRpLN5xM/ZDLeJ0AcwgR/pB5OpMp1
        7o166G7VPCyaCdx3tJNf9T+q9pOST0sjq/7g8/3QyDRQOvQgFKLFKcamEJAgImmaJSP7jsunAS2hz
        sQfUfBMym7HmbGVr3WzIstGlBYqqHWdJA1zprYCnlivNnwA3Qqoz4Y2OrvtetFUeU1p8WET6/IrOv
        HXEhNBQw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqele-00GXai-1C;
        Wed, 11 Oct 2023 19:21:14 +0000
Message-ID: <cad53122-c50f-4f24-ac62-eea192669f2b@infradead.org>
Date:   Wed, 11 Oct 2023 12:21:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [char-misc-next 3/3] mei: docs: fix spelling errors
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
References: <20231011074301.223879-1-tomas.winkler@intel.com>
 <20231011074301.223879-4-tomas.winkler@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231011074301.223879-4-tomas.winkler@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 00:43, Tomas Winkler wrote:
> Fix spelling errors in the mei code base.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/bus.c       | 4 ++--
>  drivers/misc/mei/dma-ring.c  | 2 +-
>  drivers/misc/mei/hbm.c       | 4 ++--
>  drivers/misc/mei/interrupt.c | 2 +-
>  drivers/misc/mei/mei_dev.h   | 4 ++--
>  include/linux/mei_cl_bus.h   | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
> index 2e65ce6bdec7d9c561ccd2c8..67557c67bd214415b8dc6747 100644
> --- a/drivers/misc/mei/bus.c
> +++ b/drivers/misc/mei/bus.c
> @@ -1301,7 +1301,7 @@ static inline void mei_cl_bus_set_name(struct mei_cl_device *cldev)
>   * @bus: mei device
>   * @me_cl: me client
>   *
> - * Return: allocated device structur or NULL on allocation failure
> + * Return: allocated device structure or NULL on allocation failure
>   */
>  static struct mei_cl_device *mei_cl_bus_dev_alloc(struct mei_device *bus,
>  						  struct mei_me_client *me_cl)
> @@ -1361,7 +1361,7 @@ static bool mei_cl_bus_dev_setup(struct mei_device *bus,
>   *
>   * @cldev: me client device
>   *
> - * Return: 0 on success; < 0 on failre
> + * Return: 0 on success; < 0 on failure
>   */
>  static int mei_cl_bus_dev_add(struct mei_cl_device *cldev)
>  {
> diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
> index ef56f849b251d77b87767d48..e5d800e68cb186ce82d715b6 100644
> --- a/drivers/misc/mei/dma-ring.c
> +++ b/drivers/misc/mei/dma-ring.c
> @@ -161,7 +161,7 @@ static size_t mei_dma_copy_to(struct mei_device *dev, unsigned char *buf,
>  /**
>   * mei_dma_ring_read() - read data from the ring
>   * @dev: mei device
> - * @buf: buffer to read into: may be NULL in case of droping the data.
> + * @buf: buffer to read into: may be NULL in case of dropping the data.
>   * @len: length to read.
>   */
>  void mei_dma_ring_read(struct mei_device *dev, unsigned char *buf, u32 len)
> diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
> index 12a62a911e4237aad8bc381b..15737655c896c8b5835288ea 100644
> --- a/drivers/misc/mei/hbm.c
> +++ b/drivers/misc/mei/hbm.c
> @@ -111,7 +111,7 @@ void mei_hbm_idle(struct mei_device *dev)
>  }
>  
>  /**
> - * mei_hbm_reset - reset hbm counters and book keeping data structurs
> + * mei_hbm_reset - reset hbm counters and book keeping data structures

s/book keeping/bookkeeping/

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>   *
>   * @dev: the device structure
>   */
> @@ -907,7 +907,7 @@ int mei_hbm_cl_disconnect_req(struct mei_device *dev, struct mei_cl *cl)
>  }
>  
>  /**
> - * mei_hbm_cl_disconnect_rsp - sends disconnect respose to the FW
> + * mei_hbm_cl_disconnect_rsp - sends disconnect response to the FW
>   *
>   * @dev: the device structure
>   * @cl: a client to disconnect from
> diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
> index 0a0e984e56736cd0ece88f41..5a050f50f33e3a6a64e7c7c2 100644
> --- a/drivers/misc/mei/interrupt.c
> +++ b/drivers/misc/mei/interrupt.c
> @@ -72,7 +72,7 @@ static void mei_irq_discard_msg(struct mei_device *dev, struct mei_msg_hdr *hdr,
>  		discard_len = 0;
>  	}
>  	/*
> -	 * no need to check for size as it is guarantied
> +	 * no need to check for size as it is guaranteed
>  	 * that length fits into rd_msg_buf
>  	 */
>  	mei_read_slots(dev, dev->rd_msg_buf, discard_len);
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
> index cdf8a2edf0b32b7dd6a0af53..fca0094a2310e4a2710883ac 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -70,9 +70,9 @@ enum mei_dev_state {
>  /**
>   * enum mei_dev_pxp_mode - MEI PXP mode state
>   *
> - * @MEI_DEV_PXP_DEFAULT: PCH based device, no initailization required
> + * @MEI_DEV_PXP_DEFAULT: PCH based device, no initialization required
>   * @MEI_DEV_PXP_INIT:    device requires initialization, send setup message to firmware
> - * @MEI_DEV_PXP_SETUP:   device is in setup stage, waiting for firmware repsonse
> + * @MEI_DEV_PXP_SETUP:   device is in setup stage, waiting for firmware response
>   * @MEI_DEV_PXP_READY:   device initialized
>   */
>  enum mei_dev_pxp_mode {
> diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
> index fd6e0620658d6515b3e234ce..c9af62e54577033bf9bae0e4 100644
> --- a/include/linux/mei_cl_bus.h
> +++ b/include/linux/mei_cl_bus.h
> @@ -31,11 +31,11 @@ typedef void (*mei_cldev_cb_t)(struct mei_cl_device *cldev);
>   * @rx_work: async work to execute Rx event callback
>   * @rx_cb: Drivers register this callback to get asynchronous ME
>   *	Rx buffer pending notifications.
> - * @notif_work: async work to execute FW notif event callback
> + * @notif_work: async work to execute FW notify event callback
>   * @notif_cb: Drivers register this callback to get asynchronous ME
>   *	FW notification pending notifications.
>   *
> - * @do_match: wheather device can be matched with a driver
> + * @do_match: whether the device can be matched with a driver
>   * @is_added: device is already scanned
>   * @priv_data: client private data
>   */

-- 
~Randy
