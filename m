Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9A7A95DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjIUQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIUQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DCBCC;
        Thu, 21 Sep 2023 09:56:19 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360722530"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="360722530"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 03:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="994018928"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="994018928"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 03:00:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qjGTr-0000000GrBd-111u;
        Thu, 21 Sep 2023 13:00:19 +0300
Date:   Thu, 21 Sep 2023 13:00:18 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] pinctrl: Add driver support for Amlogic T7 SoCs
Message-ID: <ZQwUMqPG2Z+Y/FTF@smile.fi.intel.com>
References: <20230921083407.1167510-2-huqiang.qin@amlogic.com>
 <20230921083407.1167510-4-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921083407.1167510-4-huqiang.qin@amlogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 04:34:07PM +0800, Huqiang Qin wrote:
> Add a new pinctrl driver for Amlogic T7 SoCs which share
> the same register layout as the previous Amlogic S4.

...

> +static const char * const uart_ao_a_groups[] = {
> +	"uart_ao_a_rx_c", "uart_ao_a_tx_c", "uart_ao_a_tx_w2",
> +	"uart_ao_a_rx_w3", "uart_ao_a_tx_w6", "uart_ao_a_rx_w7",
> +	"uart_ao_a_tx_w10", "uart_ao_a_rx_w11", "uart_ao_a_tx_d0",
> +	"uart_ao_a_rx_d1",

> +

Redundant blank line.

> +};

With that fixed,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


