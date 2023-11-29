Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854577FD3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjK2KMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2KMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:12:52 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A8510C7;
        Wed, 29 Nov 2023 02:12:59 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 8830B603F4;
        Wed, 29 Nov 2023 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701252778;
        bh=kFUarNKDlqDSpl/U8/e1n11XHnBUqLk96wjayppBZw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qStEwad/kZ7owqPHlhNKu2EyvBEpUPG/O11tV4lM9EW6E4Q1YGdtdZtkSrOujWCzp
         9CtaV/ijIy2ZyheSz50ckYjPjXGOVKZH4mFm14wSooL+0Nh73NeEpGctN/sxnsXohU
         6qZ7RHBFYgQAqf9N5usTZWP3w3pX1Lx1AXmObjrMAxBZfL5PsPOM/8p+h+aUpZsED8
         ZEFA52VbgIpRZN0syT36JYBOEJwOC0yiGqrOYaTJw7xFHSXknfhNHdcCjchIPwAztG
         iyfKNvRM4thb65lDlTUmUE2KHeK72CGuzYl5sqUJcAWHkt+lOJ9DjH2duLnqxD1I36
         YqJez7UFFIjmQ==
Date:   Wed, 29 Nov 2023 12:12:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com,
        sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, kristo@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: ti: Convert interface.txt to
 json-schema
Message-ID: <20231129101233.GV5169@atomide.com>
References: <20231127202359.145778-1-andreas@kemnade.info>
 <20231128171647.GA3343123-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128171647.GA3343123-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rob Herring <robh@kernel.org> [231128 17:16]:
>    1341 ['ti,clkctrl']

Are the 1341 ti,clkctrl warnings node name underscore warnings?

If so I think I have a patch already for some of those that I need
to dig up and finish..

Regadrs,

Tony
