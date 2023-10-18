Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86A7CD922
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjJRKYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjJRKYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:24:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35FC1B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697624637; x=1729160637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omynuW7I9or0lJmk/yREjU5Lhj/eeHnYKy2S+nUuHeU=;
  b=DT9Qct9DHmAoobcvU85IFCCPkNZ+n5XOFza5/73+RirzfhL1UCj7FP27
   zoEvy7UzgAPRxqznRj/s9GoHmbhQ42epvtCzAujahYZdmSMJWLWCwc3Sd
   P2wDvNl89GR6L7Dj9VpFQBUFsQv3rKr3esW8Oh+/XajDiVY5Tc3gHyTPp
   QHwQe2NLxXMvJNeoPcSPf9G72U8aE3uC0zLCVl3YP7V0ABr0Mgqp0JOMX
   RpDcj3zTJnbFwemdBkig+lzvUReFUFxIGT24PNjgqiG24S8HocKsqG9hw
   DrQY5IS1fgMCmSiqbyr1o2Ole9H9PsKypDwtFMu5oN1S78KcJDiGRwQCi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="417097650"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="417097650"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087886761"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="1087886761"
Received: from nurfahan-mobl3.gar.corp.intel.com (HELO intel.com) ([10.213.159.217])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:23:34 -0700
Date:   Wed, 18 Oct 2023 12:23:26 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gdm724x: Add blank line after declaration
Message-ID: <ZS+yHg8uILyX4uHo@ashyti-mobl2.lan>
References: <20231018044609.22616-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018044609.22616-1-soumya.negi97@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soumya,

On Tue, Oct 17, 2023 at 09:46:07PM -0700, Soumya Negi wrote:
> Fix WARNING: Missing a blank line after declarations
> Issue found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>

Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 

Thanks,
Andi
