Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2042A8005CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377854AbjLAIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjLAIhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:37:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9E01712
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:37:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C04C433C9;
        Fri,  1 Dec 2023 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701419865;
        bh=vwfvlYF1Ql3h7BF9nsm39RTMqOUzKsLqOB50UqUXBjA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VK5oqLyBqvMLA+eGbkLMBFgaWYBNu7SwDEy/2Vu0/2rCRtSYroTn06gDojGhPxsre
         9/raSZkDuWXNyAWGkcfuZ1LHLLNTmrW7B+BV6mgKiokA5rFSnc3ezdy7Gc7P2+R9He
         yTq2ipWxqc52qTz2wHVMFz6MHtGig0GjAbXgccGDqfq4/A+I4Zfhnq9ZtFhIxVgYIc
         +bTcjq8xfccaIPs/clHBBOMUWXokj6yGZcoD4KwOwr0LJENFj4wJF7wbNf93vvkbfa
         RB7zxImckcNBfVZ7gVMLycAKruqbdPvVBCUkd/+y2W5KWR/pZok44zZJLvtEoOJ3dG
         WEV2wu8VncCCg==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     matt.coster@imgtec.com, frank.binns@imgtec.com,
        boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231129153703.162642-1-donald.robson@imgtec.com>
References: <20231129153703.162642-1-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH 1/5] drm/imagination: Fixed warning due to
 implicit cast to bool
Message-Id: <170141981127.3198685.4985387071674104963.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 09:36:51 +0100
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

On Wed, 29 Nov 2023 15:36:59 +0000, Donald Robson wrote:
> 


Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

