Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE28085E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjLGKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjLGKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:07:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B75A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701943667; x=1733479667;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uk15A8QKQ8ycJNU0cX26IuAICSD58obvOMcwCOOR8g0=;
  b=mWpaxI+1JPS2z42eWE0ZuLRawt2Jc6849LMjCMmF42YUMHU1ERa6b0bG
   qYkSpxszLsbzfvReCZp+j85Lu/i6FVmWUmwnZhnqBzALiD0FEG3tr9hqO
   ANlobPzDhXZu1g/3RJZ1wY5jOAvhn06OrHdFL2vAjG/RvPOnASNdb2ajN
   fJsqrUT8DmxZslme+0ULrbS+fyO0GDIAzNChgt/XkId/eA5FuKVZdzHoG
   1ZZdDeddoU0nRu7Um8mk+ZVw6TPh4/XsMDrx0U39TjwF0y6SbITbxhnQ+
   jlVvp1u5D2W3pSnGwZErX4QCiLx058q9PgbM9HGaWqkRsbPeDA1GqX5//
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12922231"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12922231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 02:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="862430968"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="862430968"
Received: from mrehana-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.169])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 02:07:43 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     bbaa <bbaa@bbaa.fun>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Bug Report] drm/edid: drm_edid_override_connector_update
 returns a incorrect value
In-Reply-To: <57BBFAAD83255278+587e2f64-3507-4af9-bca4-43194400c68c@bbaa.fun>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <57BBFAAD83255278+587e2f64-3507-4af9-bca4-43194400c68c@bbaa.fun>
Date:   Thu, 07 Dec 2023 12:07:40 +0200
Message-ID: <87fs0e1g2b.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2023, bbaa <bbaa@bbaa.fun> wrote:
> Hello everyone,
>
> drm_edid_override_connector_update seem return a incorrect value.

You seem to have posted this twice; already replied at
https://lore.kernel.org/r/87jzpq1go5.fsf@intel.com

-- 
Jani Nikula, Intel
