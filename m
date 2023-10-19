Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B67CFC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjJSOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjJSOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:22:46 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9965D138
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1697725360; x=1697984560;
        bh=BZ8m8hzLlbVZD5/QhXKn58C893KnGUrMpTj8JXVT2AQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=H1+Oki2gdHeuc6uivf186YbX2aVRFqzk58KCtapUjdpyeKLfc5ViwjbyW2II5GrTa
         /yR0xnHBhij7EQ2JA5fZaDKvuYEFJVMkre4vMlYsGIO2ell5EmA1iwOLN40tEQJqni
         G1KRtiMj0y6IpDTlq4w/S7tenbCaccDBpYGAlRTRSWQE2Jzi/fxyXRvYlbLKbviMRr
         3aHhp8IQIN+bfXRDhznoO98LLye2JlbEM1qFz/FP5TkS2exNtNPbrvtS79rFCR0V2n
         YYxjTVAJeUoNV2w4FC7qpiQDdab95M1YE59+q9wIMhAzU6lgGJU7LvO2s7+HRfhs1B
         tEmNUaSoNn/Fg==
Date:   Thu, 19 Oct 2023 14:22:28 +0000
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        laurent.pinchart@ideasonboard.com, sebastian.wick@redhat.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC v6 01/10] drm: Introduce pixel_source DRM plane property
Message-ID: <DrmsyZK_ptUMO9pdU0ESXgVdv4Mjhp_A5A0x6U4N3HoKNQZKfU4E4xNPN-PXa4gpxqk-Urv8-9mWWTK8GUcadIX61FttgzCJOL-Nszh0n9w=@emersion.fr>
In-Reply-To: <20230828-solid-fill-v6-1-a820efcce852@quicinc.com>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com> <20230828-solid-fill-v6-1-a820efcce852@quicinc.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the uAPI:

Acked-by: Simon Ser <contact@emersion.fr>
