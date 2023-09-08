Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D747983E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjIHIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjIHIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:20:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B7173B;
        Fri,  8 Sep 2023 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694161235; x=1725697235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvNQ9uU/kK3N8/bDrmxpdKy+upygvoAdffwYay19gfA=;
  b=ieK3cCp8BReMV6svQsVjbE8GOv3lkZPmwbs9CaZ+XQX0xMgFABiqAw7v
   tzN62+L2rQTNivgjXovbQoQQ+l3BaQZrnIe0W+2CppnDhZB5nMScfFqbE
   Ozqtdurbag5bHSxka+tHjK42Hh4Gi+NZOLFDYA/HJX7M3ALcFfhKuyXT6
   M3TLGKg0ZN2Tzg4wKb31dq649Ys0yGasGVnfQ+VTrFyu82FO2FfohWcC9
   A/u4C2HI/3ztll6fExAimEYcWZtnzsZOHLe9oYtiBeustAJClVVpfWurY
   ZOx+Z35A/Ihx8iwfKLegd4NqcG16QjMSYKd22lBNQ4QiyxB+ihUuaL7M7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="444027467"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="444027467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 01:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="742428329"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="742428329"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga002.jf.intel.com with SMTP; 08 Sep 2023 01:20:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Sep 2023 11:20:31 +0300
Date:   Fri, 8 Sep 2023 11:20:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/5] usb: typec: tcpci_rt1711h: Remove trailing comma
 in the terminator entry for OF table
Message-ID: <ZPrZTgx7nVxhHean@kuha.fi.intel.com>
References: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
 <20230906080619.36930-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906080619.36930-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:06:15AM +0100, Biju Das wrote:
> Remove trailing comma in the terminator entry for OF table.
> While at it, drop a space in the terminator for ID table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2->v3:
>  * Dropped updating I2C driver data in ID table as there is no user yet.
>  * Updated commit header and description.
>  * Added Rb tag from Andy.
>  * Retained the Rb tag as it is trivial change.
> v1->v2:
>  * Drop space from ID table
>  * Remove trailing comma in the terminator entry for OF table.
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 17ebc5fb684f..6146bca8e55f 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -394,7 +394,7 @@ static void rt1711h_remove(struct i2c_client *client)
>  static const struct i2c_device_id rt1711h_id[] = {
>  	{ "rt1711h", 0 },
>  	{ "rt1715", 0 },
> -	{ }
> +	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>  
> @@ -402,7 +402,7 @@ MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>  static const struct of_device_id rt1711h_of_match[] = {
>  	{ .compatible = "richtek,rt1711h", .data = (void *)RT1711H_DID },
>  	{ .compatible = "richtek,rt1715", .data = (void *)RT1715_DID },
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(of, rt1711h_of_match);
>  #endif
> -- 
> 2.25.1

-- 
heikki
