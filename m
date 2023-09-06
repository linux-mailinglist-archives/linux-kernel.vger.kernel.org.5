Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603CC793BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbjIFLxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjIFLxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:53:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC327199;
        Wed,  6 Sep 2023 04:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75EAC433C8;
        Wed,  6 Sep 2023 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694001219;
        bh=bwfka+JpEPprvMJfxECixELCrmxr7bmCc76S67cIWJc=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=pMq9vRCjBQipcs/aGh/mqFdWLTVT6zoNUA45SoqJkid4FVZFVHUKDSkn8We/Lnk49
         Sl4CzaRMQEeJR+5N+R98d62v8tOnx4oBqbZw2c+7MrGq3BruD17BAF6+lkbDb8ERuF
         s++0s/mxgKte4JV8lE75+9388UVUqZcjtSgk3aweApo1nb3wta8sy6tALPX8aC6WNj
         EYPa9T2cMpc2dPujrkpRxZtl4d4QgL2FTl8OfK9I5Xg6CFaUTolcjrShhaucDCI03/
         U589q3S+QVP08oGXMJvETk42p4BPPJNtCBSgLccvNLp79AYZ8YJxwoY8BXX4fl0ZNR
         plgeXBLDN5VEw==
Message-ID: <e4f53f712d7a98c974fc04788720ce78.mripard@kernel.org>
Date:   Wed, 06 Sep 2023 11:53:36 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Sarah Walker" <sarah.walker@imgtec.com>
Subject: Re: [PATCH v6 07/20] drm/imagination: Add GPU register headers
In-Reply-To: <20230906095542.3280699-8-sarah.walker@imgtec.com>
References: <20230906095542.3280699-8-sarah.walker@imgtec.com>
Cc:     afd@ti.com, airlied@gmail.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, conor+dt@kernel.org, corbet@lwn.net,
        dakr@redhat.com, daniel@ffwll.ch, devicetree@vger.kernel.org,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        faith.ekstrand@collabora.com, frank.binns@imgtec.com,
        hns@goldelico.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, luben.tuikov@amd.com,
        maarten.lankhorst@linux.intel.com, matt.coster@imgtec.com,
        matthew.brost@intel.com, mripard@kernel.org, robh+dt@kernel.org,
        tzimmermann@suse.de, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2023 10:55:29 +0100, Sarah Walker wrote:
> Changes since v5:
> - Split up header commit due to size
> 
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
