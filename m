Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3827E5A21
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjKHPgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjKHPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:36:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7A1FD5;
        Wed,  8 Nov 2023 07:35:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B143C433C8;
        Wed,  8 Nov 2023 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457759;
        bh=eE6mOmTr1rj6VsFKkbtQZvA22hyfF/rlsdneGdInYVg=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=TnawTsGuBBEORxekcBAmA+jjMHWmLN4XWGen0+F+lzTD0iGo8W2tgn4kqlkbO0UPU
         Yg5DELitXP/3jDF2mJBGoSiOS+uDJJ6MRAC3grJh8N/HyMs6+aDCC42QtUZtNOSeKc
         DkwygnSAdlfY5aLlamsBqwT2SPz3jalWB08GEuc7MBWDALw4d7xI8QyGAIXKbVKi4R
         DmQMKcX1uzaTaNg3f8ZUDVJdY7QS2U0GY4ts8ARpJWQFXOuLbRyWyqkR8IVsQHP0ZK
         l0Wk5oV/4lTqqS8eH1WQd8jRknt1kFge8eGRwNuaMi5JTuZXo/js4EFeJMASXzdhxD
         wXx1PNMofiEKQ==
Message-ID: <1b02163780ccd7a4ce1357ab9810bb26.mripard@kernel.org>
Date:   Wed, 08 Nov 2023 15:35:56 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Hsin-Yi Wang" <hsinyi@chromium.org>
Subject: Re: [PATCH v6 2/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02
 name
In-Reply-To: <20231107204611.3082200-3-hsinyi@chromium.org>
References: <20231107204611.3082200-3-hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Douglas Anderson" <dianders@chromium.org>,
        "Jessica Zhang" <quic_jesszhan@quicinc.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 12:41:52 -0800, Hsin-Yi Wang wrote:
> Rename AUO 0x235c B116XTN02 to B116XTN02.3 according to decoding edid.
>=20
> Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,=
836X2, NV116WHM-N49 V8.0")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
