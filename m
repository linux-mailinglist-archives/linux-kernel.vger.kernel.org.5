Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F00C7936B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjIFICC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjIFIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:01:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1341E6C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:01:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A794C433C7;
        Wed,  6 Sep 2023 08:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693987306;
        bh=lnZrIvfAWrPfKvf/5nuj4+NDBonPVQoFp84luU6Fq5A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LqB9YfF/yrQciqfqUZOI2RVJ2mCkio2FAi4dpXTWKwuGIQivDc+V5/vaXkUNvFf+S
         VlDevJQu5Z+p7/8lwpxmN3pFnL0PdVOG32Ytq4tqZ92s1rmsSg4g0/eO6aySRvrhXZ
         06ACuLKe7XEPJNL2Kta/l0kHwG5eodZ3moIjrlO3Yg6c4Yyw8W8yzwle+qu6DVlBsa
         vYOLIPhqTRxQbTKW90mouYQPoY7DZ9HgCei2PA7HPPAuORNFjcswuD/Q7yzArr/ImU
         1Cvtbvmjwz4rRgwtJ/VwKTLPRMnGpaIV2xwIKRDuXRJ+0950sAl8t6Vh33Isz2a+c+
         c/X86VpNP91fQ==
Message-ID: <e9880548-11c5-2790-7c77-7ca031849182@kernel.org>
Date:   Wed, 6 Sep 2023 10:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 4/9] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-slave-v1
To:     Frank Li <Frank.Li@nxp.com>, miquel.raynal@bootlin.com
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
 <20230905213842.3035779-5-Frank.Li@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230905213842.3035779-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 23:38, Frank Li wrote:
> Add compatible string 'silvaco,i3c-slave-v1' for slave mode.
> 

No, it's the same device.

Anyway, this was not tested.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


Best regards,
Krzysztof

