Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47C275D6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGUVhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGUVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:37:45 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9DB272D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:37:41 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id cc4c06f2-280e-11ee-a9de-005056bdf889;
        Sat, 22 Jul 2023 00:37:32 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 22 Jul 2023 00:37:31 +0300
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 6/8] iio: core: Fix issues and style of the comments
Message-ID: <ZLr6m5wHBSLKensj@surfacebook>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-7-andriy.shevchenko@linux.intel.com>
 <db709099-a2aa-c03f-61bb-6130adfd6f4a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db709099-a2aa-c03f-61bb-6130adfd6f4a@infradead.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jul 21, 2023 at 01:48:34PM -0700, Randy Dunlap kirjoitti:
> On 7/21/23 10:00, Andy Shevchenko wrote:

...

> > - * Return: 0 for successful release
> > + * Returns: 0 for successful release.

> As documented in Documentation/doc-guide/kernel-doc.rst:
>   The return value, if any, should be described in a dedicated section
>   named ``Return``.
> 
> However, as you (and I) have found, "Returns:" also works as a section name.

Plural allowed for some section(s):
'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$'

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


