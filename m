Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C837E4A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbjKGU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjKGU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:57:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B310CC;
        Tue,  7 Nov 2023 12:57:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE8CC433C8;
        Tue,  7 Nov 2023 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699390669;
        bh=7ACRIJLIIhFRewyxES9jU9BE2vJL6M7MNnNGzJ/Oz70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdW1pJ4btgVPWhLMSRJXq/fIAtmWunmaqDFty+qi1fsCLh9ia4kbvkg/nWfzzNMKP
         h4dcyxKNwjaxHfB0PT+CYgRXoriPiiMIyPzhvFB/kTcC5qJrBwwawuf1ha06Hrbiw+
         KSBfQHO1aZdXCHpjJrDYsstalJ5DLxdXA1yFVmOE=
Date:   Tue, 7 Nov 2023 21:57:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 3/5] drm/panel-edp: drm/panel-edp: Add several generic
 edp panels
Message-ID: <2023110739-parmesan-exposure-8225@gregkh>
References: <20231107204611.3082200-1-hsinyi@chromium.org>
 <20231107204611.3082200-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107204611.3082200-4-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 12:41:53PM -0800, Hsin-Yi Wang wrote:
> Add a few generic edp panels used by mt8186 chromebooks.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> no change.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 51 +++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
