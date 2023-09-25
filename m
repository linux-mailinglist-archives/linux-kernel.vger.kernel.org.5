Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871557AD411
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjIYJDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjIYJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:03:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04946AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:03:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D420C433C8;
        Mon, 25 Sep 2023 09:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695632586;
        bh=rBtxIFwUV7tP2BI4dzvLA1kJx9ks66XoMW4eWCsCmfM=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=mC06m7MlbVTYb/om+FqGWOUi75zxM5gQ4BCLVDJIinsvGirE8iEF1cy+OjvIBKp1a
         zwrzPWhhuLRfeuOknA6CBAwAy1SdeirYju6FC1W0si4usTxVxsTfLUr/XV11yQ77vD
         6xd7yRUNvgsNe0jM30XfCGLSTmAMebpT8oDez+oExs7IgdeCpt/v2aFDL+71zFI8vY
         5ASP4bzEpHmjOC9YUlghzzn3ivf+qt28/hpFd4wxzoTm/Bu8azYDoVy8+Tj//Y/YzQ
         5AWIySQcLBhLYSgph+TSnyADgnqF8rb+UYyPr4Bm4qX75I5DghNaCueOv8E/60fm1T
         hZz/s0YU2KMmA==
Message-ID: <17dc594f38ff2b7c1b5a1cd5974f7d9f.mripard@kernel.org>
Date:   Mon, 25 Sep 2023 09:03:04 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Helen Koike" <helen.koike@collabora.com>
Subject: Re: [PATCH v2 2/2] drm/ci: add tests on vkms
In-Reply-To: <20230922171237.550762-3-helen.koike@collabora.com>
References: <20230922171237.550762-3-helen.koike@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, daniel@fooishbar.org,
        dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org, mairacanal@riseup.net,
        melissa.srw@gmail.com, michel.daenzer@mailbox.org,
        mripard@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, robdclark@gmail.com,
        rodrigosiqueiramelo@gmail.com, vignesh.raman@collabora.com,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 14:12:37 -0300, Helen Koike wrote:
> Add job that runs igt on top of vkms.
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
