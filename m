Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5194E7C596E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjJKQo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjJKQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:44:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC708F;
        Wed, 11 Oct 2023 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697042697; x=1728578697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=poJuXecoStHQJe7+pcHpwvtQoY5mTPxBgB6f7CIRll8=;
  b=SM+j3wmlMdUe8+8TNqv8c3Ny1deGtE11NuThNs+XDhfnye8jf9qHIgUR
   kqCM9c116YBXFC6ynPLNvqGeSyAyrgaiT/Wr2mtSIp7TLxyXJXycL2CUX
   eUK/Krf5prW5nPBhC1RxWpDz2EcZqQPyrZwldcfrlmGrAYANPAJFk0koL
   PrU3VcLZefCOcmAHAhYixth4Rvw6uNxM3GvqURyV0DqEpevSGjUA3ES0g
   HOxrtJQc1kaedcypXSZMqZd4LuEpG6itRM0WNAABOSjP0N/u70kYMd1Z+
   eDhF5XvATL7c3LmdsTCMq79+UMh+EQ5yP5aKIEkobaAITp5PKspdQVfN0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383577960"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="383577960"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="1085296587"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="1085296587"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:44:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqcKK-00000004muq-3dtN;
        Wed, 11 Oct 2023 19:44:52 +0300
Date:   Wed, 11 Oct 2023 19:44:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 01/62] pinctrl: remove unneeded extern specifiers from
 consumer.h
Message-ID: <ZSbRBDONx/epMABs@smile.fi.intel.com>
References: <20231011120830.49324-1-brgl@bgdev.pl>
 <20231011120830.49324-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011120830.49324-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:07:29PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The 'extern' specifiers are not needed for function declarations. Remove
> all of them from the pinctrl/consumer.h header.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


