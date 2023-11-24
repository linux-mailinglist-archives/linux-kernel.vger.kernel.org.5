Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9927F7196
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345526AbjKXKfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:35:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05616D69
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:35:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F50EC433C8;
        Fri, 24 Nov 2023 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822122;
        bh=H+nXekQkf9XBvY1ESMqyZIEqP3DaxDh+lS5/L2SdOxA=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=JeAVkrlT0JUtUSZHnsWzFlVtrXd1jk4LmmlEePsz4eSdJSF8ECxx6slpyiS7xTSOQ
         XLVdMkamyEMILzaPLP9l2OoAPhYAMBum4iSEl40sOaT9Cd8mkbPHhsHnX6MXaeVNm1
         pGrxLhUDuTpeFOMGoufKLUDNkMX8iFP4DS/O7HLe9OiDF5QQI//y3KLwfqtDIMdhSp
         vLQAVDwnZm6KkPgHXLIAZ5oxN+WJhAz2gE9Yzro1Mv9UuqXZF2dbrXfpmtl87MvGuM
         rSQr8NecK7JaxZ7HIzrdEFjEeCRY6mdY1Ww8G6aQ2tz5JQj6yGrUgDRuxbptA82BH3
         dpyeIFuqI2h2Q==
Message-ID: <a8383fc4d59952d74816b16a1a1c322a.mripard@kernel.org>
Date:   Fri, 24 Nov 2023 10:35:20 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 02/26] drm/gem: Add _locked postfix to functions
 that have unlocked counterpart
In-Reply-To: <20231029230205.93277-3-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-3-dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        "Chia-I Wu" <olvaffe@gmail.com>,
        =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Emma Anholt" <emma@anholt.net>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Gurchetan Singh" <gurchetansingh@chromium.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Melissa Wen" <mwen@igalia.com>, "Qiang Yu" <yuq825@gmail.com>,
        "Steven Price" <steven.price@arm.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 02:01:41 +0300, Dmitry Osipenko wrote:
> Add _locked postfix to drm_gem functions that have unlocked counterpart
> functions to make GEM functions naming more consistent and intuitive in
> regards to the locking requirements.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
