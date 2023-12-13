Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1181160F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442492AbjLMPW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442482AbjLMPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:22:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63770EB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:22:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F2AC433C8;
        Wed, 13 Dec 2023 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702480952;
        bh=BOQd2PqXMpAxHexTtrg3Hc/jZKTRaDU86+Gy/WOQqb0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eiAaLRm5mrz59icZnSi+8PFM6WxsVnO8pdVog6uGR4xoRDslpVCu34yYlSUuXiAmP
         ioAypIeUWEjoWmnn0FbvxS06sEtNlQKTjv5CKwNzC9uXmyhnHaLWhFeSVWETu73G2Y
         JZJosbMaloJjyhbRCOm4tjN1XAVhSpGDZQgVubXfK6dRz5kxyNCHSbBUj0LrnNQeOZ
         RwWQJV+kLbPm6qjtDD2zov+a0MHKfOZfVjKhtbfId+6p85QniyLs9qyYmTRlQmKaO3
         onlNOj41WsCf5YhQH9E8ENE2EDEJlL/X9UU4WxpyTryzzgLhNh70QvvG/pOeemwv4b
         ik7UYKVHcefTg==
From:   Maxime Ripard <mripard@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     neil.armstrong@linaro.org, robh@kernel.org, daniel@ffwll.ch,
        michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        airlied@gmail.com, quic_jesszhan@quicinc.com,
        maarten.lankhorst@linux.intel.com, sam@ravnborg.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org
In-Reply-To: <20231213112401.2000837-1-dario.binacchi@amarulasolutions.com>
References: <20231213112401.2000837-1-dario.binacchi@amarulasolutions.com>
Subject: Re: (subset) [linux-next:master] drm/panel: ilitek-ili9805: adjust
 the includes
Message-Id: <170248094841.191897.812940290291965613.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 16:22:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 12:24:01 +0100, Dario Binacchi wrote:
> Adjust the includes to explicitly include the correct headers.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

