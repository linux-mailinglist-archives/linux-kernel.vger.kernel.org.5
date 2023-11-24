Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC17F7199
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345377AbjKXKgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:36:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4F110
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:36:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4786EC433C7;
        Fri, 24 Nov 2023 10:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822187;
        bh=dwvET0tU2J4anZFCWNw+ZZdWZ1IJPa1GnEWhl08aDOY=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=MM9kpBK+yisLDCYJftMOvpfpu6pOA725LB5EXxmwkvXFqByoAqaB5X89kowP4w0yj
         zb681yXDg8hPDrvyYZXlz+nWipEQ6BGPdt591lhsL/JTR6pU7IR/QBTw4RlUo3UEPm
         vC/kRYKYyX83Sxk689k6xefJdd68JBlWNtrjZSm0ry5RNYhbAkWK9NQxctEyrvjMr4
         xbnGOxoOeDpcJBhVIHprlpn+i0ZjjweSibtSihYi81RQOfNUP9N4xSSsnH+q/ioJtn
         8T5MLJWcclvP5CfJY/zAbPj04zqAUA2KCtIClU2XCyjdsjl0WzOhFsK6Bs5ZQJXnsu
         xRJE8DkkXQncQ==
Message-ID: <f27d3ba73b506111583b2a4f2471dfc9.mripard@kernel.org>
Date:   Fri, 24 Nov 2023 10:36:24 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 03/26] drm/shmem-helper: Make all exported symbols
 GPL
In-Reply-To: <20231029230205.93277-4-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-4-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:42 +0300, Dmitry Osipenko wrote:
> Make all drm-shmem exported symbols GPL to make them consistent with
> the rest of drm-shmem symbols.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
