Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD19676B355
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHALeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjHALeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:34:14 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17823D3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690889654; x=1722425654;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZFlr8Ova1lel+95XhQpbpQvUr8pBCW/k2p17P2zQdT0=;
  b=RFyGAsj0aMitqyhvPmMC7hQII6LHphNjPu8F6m4iCfp4V/0WrylEolSz
   m4YdCGydYYPisMhinXbsjBTN2vIsZX525i/MirbkvaGIPlhYYakACU3Oj
   W3zK69rkcHQ9owv+h8RACennMfkOtfJ+Vt7/w2kdHhkt6bXEWcFrKFVnj
   ov89ymtxurl9vZtyDDiJlktmk7ToIKDRC2hDWf+RVVVAxPLrwbMNDrb2W
   bAc5Hh+Aqs4ccM2CKi4A+eq9d76F47J/VRJLBlsBjWFiByCrTQ8V2ng8A
   UATwnn4MqhxpWdCM7i55jnb/fi5+nspeOA0b+Jaw5oxwbldbDc4zK9l8F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349568218"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="349568218"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 04:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731944500"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="731944500"
Received: from igorban-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.36.188])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 04:34:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ran Sun <sunran001@208suo.com>, alexander.deucher@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu73_discrete.h
In-Reply-To: <ZMjposYeMFxU5nE9@debian.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230801100024.8215-1-sunran001@208suo.com>
 <ZMjposYeMFxU5nE9@debian.me>
Date:   Tue, 01 Aug 2023 14:34:09 +0300
Message-ID: <87cz07vvwu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> And it is unfortunate that you and @208suo.com people doesn't reply to
> review comments (try searching lore.kernel.org)

Essentially a one-way firehose of patches pointed at our general
direction is not benefitial to the community. It's not participation,
it's not co-operation. If the review gets ignored, why should we invest
our time on *any* of the patches?


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
