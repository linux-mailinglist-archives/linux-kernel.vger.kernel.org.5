Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD9793543
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbjIFG1A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjIFG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:26:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08AE4A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:26:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qdlzh-0003BQ-Jy; Wed, 06 Sep 2023 08:26:29 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qdlzf-004MiR-BI; Wed, 06 Sep 2023 08:26:27 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qdlze-0003WN-36;
        Wed, 06 Sep 2023 08:26:26 +0200
Message-ID: <a0894d3dece496f6d2d8bf4e5379794369d48a9e.camel@pengutronix.de>
Subject: Re: [RFC PATCH 0/3] Introduce reset driver for T-HEAD th1520 SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kwanghoon Son <k.son@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Wed, 06 Sep 2023 08:26:26 +0200
In-Reply-To: <20230904042559.2322997-1-k.son@samsung.com>
References: <CGME20230904042603epcas1p40f732a0ac7871371126d229945cc0849@epcas1p4.samsung.com>
         <20230904042559.2322997-1-k.son@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mo, 2023-09-04 at 04:25 +0000, Kwanghoon Son wrote:
> This patchset adds initial support for reset driver.

what is meant by "initial support"? Are there just more resets than the
two watchdog resets, or is there other functionality that might require
describing in the device tree? Is the dt-binding document complete?
Is this the only reset controller on TH1520? In the thead-kernel.git it
looks like there are at least two different ones.

regards
Philipp
