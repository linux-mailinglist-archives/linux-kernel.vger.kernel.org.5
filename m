Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B517EC241
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjKOM3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjKOM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:29:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77ECE;
        Wed, 15 Nov 2023 04:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700051367; x=1731587367;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=um309kyfbNVDejyVO3Dw51hvTyxGySUqOJwGhc+Zllk=;
  b=Bnqw28y6GsHuuiZcg8GGyiaCmTxXQljg55/iwbCKJm1S27gNYdIDTWDt
   68fWhjuRXFZZmGdNym8A64g8YQ9ZdF0nj2i2Niz66JO9HYnW3i7oLjVPQ
   d9pYCagjPr9AS9jRO0/EAM3RdjQiaxbemqDUNkWrBu/KQZ7pBa1myLNJm
   3PSft1qdXgCkUxqbhX4SWF1/91mSI0wWFNDqH20cyafDLnY+t2wognoaS
   vPec+gSKtUgpzfZTYyjYNc8mLIFVg7NGmFPaHCq4cuYmCV8uVh3QGlSh7
   Z49140tZNIs5q04tSG/iOg55eqOVJW+lHFU4lK82QS3inJlwfrpxdx2Qs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390664331"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="390664331"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:29:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1096428915"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="1096428915"
Received: from rkhristx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.217])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:29:24 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        Jithu Joseph <jithu.joseph@intel.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20231102195218.143440-1-jithu.joseph@intel.com>
References: <20231102195218.143440-1-jithu.joseph@intel.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Remove stale entry for SBL platform driver
Message-Id: <170005132163.1943.1988654330717878554.b4-ty@linux.intel.com>
Date:   Wed, 15 Nov 2023 14:28:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 12:52:18 -0700, Jithu Joseph wrote:

> Maurice is no longer with Intel and his e-mail address is no longer
> active. Remove the stale entry from Slim boot loader section.
> 
> 


Thank you for your contribution, it has been applied to my local
fixes branch. Note it will show up in the public
platform-drivers-x86/fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] MAINTAINERS: Remove stale entry for SBL platform driver
      commit: 9fadd4509966e375952f31ae954ab5eae76f90fe

--
 i.
