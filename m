Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF807CB557
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjJPVdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:33:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38548A1;
        Mon, 16 Oct 2023 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697491992; x=1729027992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eh05HXNF+uhobEEb9DOvictgVpHsWXXJ0PGHpYZu27Q=;
  b=JHGDtmsRu2QpgOCENERKHwpiNeyDA/sDGgEkwILBdM0DCR6VaQ5z+FWN
   geB27WVsSNJk/OeYERRgHCKtoRBnG/+uEciOtkevTPTHa0Le7WPpQiUcB
   KpKJBaCNK0V3cF7WLtRtoy8h+YCRohUEDACYkg2J6fESln0Zd9g/oNaqh
   fszLHOD9IwwWEhFmcmEHAJ6T4K4ko1ZEaaoyZBOli1wwgmtwEXA4Z0At8
   Xc25bJ1pHn8sues4d1F9Dfsy6RgHNbEbTs8lq8WUmTZDu4QwqVBgnVTAq
   yVIrNd4HulrVg2PKii6aXNhpLcB0nqVfnsmQjAeJLUeEMD1l5+a7IVToE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449866257"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="449866257"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="929505713"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="929505713"
Received: from yckhoo-mobl2.gar.corp.intel.com (HELO intel.com) ([10.215.157.119])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:33:03 -0700
Date:   Mon, 16 Oct 2023 23:32:56 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Staging: sm750fb: Rename
 displayControlAdjust_SM750E
Message-ID: <ZS2sCEF/LsO8Fzk1@ashyti-mobl2.lan>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-2-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201434.7880-2-anonolitunya@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:14:08PM +0300, Dorcas AnonoLitunya wrote:
> Rename function displayControlAdjust_SM750E to
> display_control_adjust_SM750E. This follows snakecase naming convention

I'd go one step further and call it display_control_adjust_sm750e.

Andi
