Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E87EE096
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbjKPMSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbjKPMSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:18:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAD99B;
        Thu, 16 Nov 2023 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700137110; x=1731673110;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=632IDd1YA/w8bQMmxOxMQIlw2Qz5AmbYHV5NAgXZ0hg=;
  b=i8UHS0P3jaimOSRZvmRSVWaZYlH8NBh7DRE4GvPsuKa25sThadfHlF/p
   oMrtLciqeuXsYYxo6fr9BlXyXGxIJ9XCMOsIk3RtAq9b80SZTFAQtH8wX
   b3AMN7cU5ckqjBuR2SkorjGg4I3DREBhG1x8ISY3q9DLti4vuz0fiHZD2
   YiMIwQHj8iwMXHTvGUqIOkN1R63cXKMtM7ue1BcY2hC35CTnMlyaxfzHd
   hom3lLIFK/I3ervIdnH9MR87FESxyEcCTcTjnPummeEUcSTeeJybfWwVR
   vd4li5m+JLFyU0k3o2kyze4GCSF/NbqeWrK4zOUFvwMMs1TSI/TG0Rzs4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422168659"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="422168659"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="715212232"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="715212232"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:17:55 -0800
Date:   Thu, 16 Nov 2023 14:17:53 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-15?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 1/5] tty: serial: amba: cleanup whitespace
In-Reply-To: <20231116-mbly-uart-v2-1-863f665ce520@bootlin.com>
Message-ID: <f674bffd-7d30-f2b1-56d-e1eb106c447d@linux.intel.com>
References: <20231116-mbly-uart-v2-0-863f665ce520@bootlin.com> <20231116-mbly-uart-v2-1-863f665ce520@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2031671838-1700137079=:1886"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2031671838-1700137079=:1886
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Nov 2023, Théo Lebrun wrote:

> Fix whitespace in include/linux/amba/serial.h to match current kernel
> coding standards. Fixes about:
> 
>  - CHECK: spaces preferred around that '|' (ctx:VxV)
>  - ERROR: code indent should use tabs where possible
>  - WARNING: Unnecessary space before function pointer arguments
>  - WARNING: please, no spaces at the start of a line
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-2031671838-1700137079=:1886--
