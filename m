Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD717D87A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjJZRiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjJZRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:38:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0B90;
        Thu, 26 Oct 2023 10:38:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A31FD36E;
        Thu, 26 Oct 2023 17:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A31FD36E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698341893; bh=hI8jFUij3FF4piDfwn/HK1OZRWtay25Ly0S5EhlKAc8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WM4R67TJHd6j3lfSVu9CkiXPFWnEsBZy1JJ2Htj0qH3+DtTH+iwKniQW/9odrxq9c
         x067wF3WrxYl4kaon9VWr/VeNc/n5mx61Lkdf8nNSPEBf2HZdaA243CsKENQYJFy5X
         ojEuw8M5ZyDEtWW9Pznk17QzCBqQ3FgnyrAsTbjquVjhZgciR9fHA0UcU8nkqLREK6
         8pVKg1AfOuLmXfG60SNV4aRPJ4IKQrxDT/VS9oVAV5xsGJ990F2bWkwhXss0DEY6Xg
         f6haofkIbWav3UnQVDLcsIbUWEodZCFtWmZ6Qzz8GfOYb+hW5pwALj2ngfuEfrIWGc
         TXXsiVvgDOTIg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     lakshmi.sowjanya.d@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, pandith.n@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v1] Documentation: driver-api: pps: Update PPS generator
 documentation
In-Reply-To: <20231016101953.27308-1-lakshmi.sowjanya.d@intel.com>
References: <20231016101953.27308-1-lakshmi.sowjanya.d@intel.com>
Date:   Thu, 26 Oct 2023 11:38:12 -0600
Message-ID: <87bkcl708r.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lakshmi.sowjanya.d@intel.com writes:

> From: Pandith N <pandith.n@intel.com>
>
> PPS documentation has a generalized section for generators. Update the
> section so any new generator documentation can be appended.
>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  Documentation/driver-api/pps.rst | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Applied, thanks.

jon
