Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D357FBAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbjK1NA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344859AbjK1NAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:00:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3AAD72
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:00:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E407EC433C7;
        Tue, 28 Nov 2023 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701176455;
        bh=hJBdeKQ+RZ6xDdb/WPig3f/tNF0FMweb3romdDHpWBo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Sq32Bh4AVEfRR2OVKWMCO0yrVJTPJIEEtqJwC9dD6hCKullwIfHzvyp+HgVX4P0Rr
         lCaSweHfCoE0O9QnuxoMufE4qHnS4o8JRJss3dYryMwqQTZviZifAx+KuvBHIRFhxU
         fOnESc9vCIpONw+HjD6npmR4ZMdNk8fuIIg4v9pHBe8MF1KMs9GHkLMyCH38LvBhAe
         yARuYpj6DFiEKyQ1Pteb2IqNjtjIvmx0WoK9X6x4FHQT9svH+f/UapU+8v3xPWBh85
         Nm49HO5USXLe8csiMIFty3aYjvpOqnlBSR8v1ysvugpxIY/apdA+Ya8msCn3yJO9tw
         X56CjZqfDhueQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20231127010430.119666-1-yang.lee@linux.alibaba.com>
References: <20231127010430.119666-1-yang.lee@linux.alibaba.com>
Subject: Re: (subset) [PATCH -next] drm/imagination: Remove unneeded
 semicolon
Message-Id: <170117645284.2825698.5291536239401902497.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 14:00:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 09:04:30 +0800, Yang Li wrote:
> ./drivers/gpu/drm/imagination/pvr_free_list.c:258:2-3: Unneeded semicolon
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

