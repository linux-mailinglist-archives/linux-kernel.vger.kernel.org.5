Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950779E6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjIMLZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjIMLZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:25:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D91726
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:25:21 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qgNzW-00048k-NV; Wed, 13 Sep 2023 13:25:06 +0200
Message-ID: <089e6ed7-4d87-9469-b547-1f14d975ed62@pengutronix.de>
Date:   Wed, 13 Sep 2023 13:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 3/3] drm/panel-simple: allow LVDS format override
Content-Language: en-US, de-DE
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523-simplepanel_support_nondefault_datamapping-v4-0-e6e7011f34b5@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v4-3-e6e7011f34b5@pengutronix.de>
 <96898dbb-3fdf-7a74-ae80-f18ae2244f50@pengutronix.de>
 <e6a2df72-46cb-4f22-b983-ac5ad2995da8@kadam.mountain>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <e6a2df72-46cb-4f22-b983-ac5ad2995da8@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 9/13/23 13:14, Dan Carpenter wrote:
> On Fri, Aug 18, 2023 at 09:04:34AM +0200, Johannes Zink wrote:
>> Hi Dan,
>>
>> do you have any input on this for me?
>>
> 
> Sorry, I was out of office and the truth is that I'm never going to
> catch up on all the email I missed.  :/
> 

nevermind, that's why I sent ping...

> Looks okay to me.  I can't remember what I said about this code in v3
> but it looks good now.  I'm not a DRM dev so I'm not sure my review
> counts for much.  

IIRC it was a mistake I made with a return value that I have fixed in v4.

You should always just assume that if I'm quiet
> then I'm happy.  :)

That's good to know ;-) Thanks for your review!

Johannes

> 
> regards,
> dan carpenter
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

