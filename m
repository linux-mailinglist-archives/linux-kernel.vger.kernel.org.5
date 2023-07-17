Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9760C755DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGQIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGQIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7EB11F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9BC60FB4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C525C433C8;
        Mon, 17 Jul 2023 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689581549;
        bh=5EaNbrHyiKLpgyLhNgjwTrv6amVL8zxsRSEPi1Z4vYA=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=XQyzQxlhMEhfdXWGHj8U9NFK3KjlwIlgE0uFVIu9mvQeUSU6nd8yklLb0/+1aP8EC
         9EAGyzqvE97D85P6sFULkd8bzvSkgOoxmbIakDBxTPyq/TTaKSiAFDac3IzAFc1l9t
         sxMTTSqe/Tkok3hqJnKj92sQRXu6WCh1JCi0Q7Y44DnhAKJpYCtah8IY+zFLrUrS+v
         PxoHKJ3GVEuG5S22b+Tme9E+WSODCZSn6Y3MRlKpeg+1NIfs93xys9OHJPzez1edDC
         4w3oXXAGoijiw+RINrqCtnv3I+EU4hxINLAmsyMwNZC570fVZ4oYJZ5uHZpEtdAjSG
         FLDCH0521gnKQ==
Message-ID: <23951965908df9775ef3437e852fbf35.mripard@kernel.org>
Date:   Mon, 17 Jul 2023 08:12:26 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Sarah Walker" <sarah.walker@imgtec.com>
Subject: Re: [PATCH v4 04/17] drm/imagination: Add skeleton PowerVR driver
In-Reply-To: <20230714142602.111681-1-sarah.walker@imgtec.com>
References: <20230714142602.111681-1-sarah.walker@imgtec.com>
Cc:     afd@ti.com, airlied@gmail.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, dakr@redhat.com, daniel@ffwll.ch,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        faith.ekstrand@collabora.com, frank.binns@imgtec.com,
        hns@goldelico.com, linux-kernel@vger.kernel.org,
        luben.tuikov@amd.com, maarten.lankhorst@linux.intel.com,
        matthew.brost@intel.com, mripard@kernel.org, tzimmermann@suse.de
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 15:26:02 +0100, Sarah Walker wrote:
> This adds the basic skeleton of the driver. The driver registers
> itself with DRM on probe. Ioctl handlers are currently implemented
> as stubs.
> 
> Changes since v3:
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
