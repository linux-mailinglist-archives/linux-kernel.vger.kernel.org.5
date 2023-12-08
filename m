Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0E809F86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573430AbjLHJgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLHJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:36:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A008A8E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:36:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBC9C433C7;
        Fri,  8 Dec 2023 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702028181;
        bh=1CQCQuBN6PFcxmLhiFIbMd1M4H+gvuAWd2IXv5gTkJs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iQV1KpsY+O0VGaqLhE++yuEtiaCmhiZb35CNR7bHrrLtJcGtXfWxpn1Oo1aoxuIYy
         doSNdfQa/yrvMxmf+bZxAH1Pfn5+gBBdHEax/TE3K8pSp7kVoCKTRsza/Thk+e6/pv
         Wq3Zv4Twz6VBKFLBZie1s7Sc7Hux3Et5n8H63EKy8c1uQ2j8Id8+ekeQIOchjCMMBA
         VugoTLzbc9I19GIjIxg8lFUsQ8tUI3oajVbwXytiJ/iiVjBTgsTrTqWdzfu0Y9oLNZ
         ZHpgvJXgfio2JDICwavJ0N++uhiBdWI31hpEPNcdPLbGeAqkMIkcCB1Xk2NShDWI+R
         WvgUB1YUBrz5A==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20231208003034.68339-1-yang.lee@linux.alibaba.com>
References: <20231208003034.68339-1-yang.lee@linux.alibaba.com>
Subject: Re: (subset) [PATCH -next] drm/imagination: Remove unneeded
 semicolon
Message-Id: <170202817893.16687.13304658818752045049.b4-ty@kernel.org>
Date:   Fri, 08 Dec 2023 10:36:18 +0100
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

On Fri, 08 Dec 2023 08:30:34 +0800, Yang Li wrote:
> ./drivers/gpu/drm/imagination/pvr_fw_trace.c:251:2-3: Unneeded semicolon
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

