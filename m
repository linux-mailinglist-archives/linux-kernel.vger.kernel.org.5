Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC67F7191
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbjKXKe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:34:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7657110
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:35:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F3BC433C7;
        Fri, 24 Nov 2023 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822102;
        bh=bTOxPls9oEkOieAEKp1Eghoi+o3SdE6s04+l2qTLwmI=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=F9d7m5tbfY6gNbZF9XgVO1y+R9k+ex3AqCRXvGShoG0t+9OreKJiWv3QNy9GnkyGk
         NGDNHUrOaTe4rDjTw4xY9KM1GlAVOLSn3tlsbIMr3QxYU3lhENxdFuqoLxREuNN97u
         zk65Ks5GpriKZOU+xFmBGVIZEhGeJ6HKo6gx1Ter+4tybGidopeB7aTm3vEnMtBu1N
         QTbztPv2jARzk6e74b4e3ElK4nzgl2V6CKJBuUNxAZyvEav1wQhYmmm3F/LqyVqL9a
         r/x9otF9P46BK96skhK4aQ96UVfbSoKBNUxOf7Y1zTB48LehKDNtDnCXCvcAS0aslF
         gniFuG49No6MQ==
Message-ID: <18807000ad1d33a0925c5470faf20fca.mripard@kernel.org>
Date:   Fri, 24 Nov 2023 10:34:59 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 01/26] drm/gem: Change locked/unlocked postfix of
 drm_gem_v/unmap() function names
In-Reply-To: <20231029230205.93277-2-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-2-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:40 +0300, Dmitry Osipenko wrote:
> Make drm/gem API function names consistent by having locked function
> use the _locked postfix in the name, while the unlocked variants don't
> use the _unlocked postfix. Rename drm_gem_v/unmap() function names to
> make them consistent with the rest of the API functions.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
