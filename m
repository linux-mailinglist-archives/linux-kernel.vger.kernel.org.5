Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECDD791072
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 05:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351353AbjIDDkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 23:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjIDDkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:40:10 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C17CC5;
        Sun,  3 Sep 2023 20:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=hXUbh5d+HTdbIDee5Rp2Uc9DuvaiGM208tOO58TGX14=; b=Q0
        IMESgljKx/McE8gf027GvjBG1ahk0QfBYjsBrHNYyvDKta6BFLIiaC2c+sP1mL2DVbzBCvSEDEKYf
        HFgwRhGCuTpqFniBUdblZgvo7jhG7aPEwZqBn3bYq9IwttHtQdcursIlzprjeX5MFSiQB5zuP6mOq
        iEMn7GGDi9cEbfg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qd0R7-005iGt-TA; Mon, 04 Sep 2023 05:39:37 +0200
Date:   Mon, 4 Sep 2023 05:39:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Qing Xu <qingx@marvell.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm: marvell: Fix maxium->maxim typo in brownstone dts
Message-ID: <8a24ae3c-30b4-489f-8f28-288f9c853d80@lunn.ch>
References: <20230826-brownstone-typo-fix-v2-1-1f8196e9a2e3@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230826-brownstone-typo-fix-v2-1-1f8196e9a2e3@skole.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 01:15:52PM +0200, Duje Mihanović wrote:
> Fix an obvious spelling error in the PMIC compatible in the MMP2
> Brownstone DTS file.
> 
> Without this, the PMIC would never probe.
> 
> Fixes: 58f1193e6210 ("mfd: max8925: Add dts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
