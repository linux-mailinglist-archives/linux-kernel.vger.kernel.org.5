Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADC771AA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjHGGrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:47:09 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF21A4;
        Sun,  6 Aug 2023 23:47:06 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id CA0D9201BC;
        Mon,  7 Aug 2023 08:47:03 +0200 (CEST)
Date:   Mon, 7 Aug 2023 08:46:59 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Devarsh Thakkar <devarsht@ti.com>, afd@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a-bhatia1@ti.com, j-luthra@ti.com,
        praneeth@ti.com, j-choudhary@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of
 global CMA
Message-ID: <ZNCNi9k2bKwbXh81@francesco-nb.int.toradex.com>
References: <20230803111455.811339-1-devarsht@ti.com>
 <20230805193355.o657pwbq2w3tciui@vehicular>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805193355.o657pwbq2w3tciui@vehicular>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 02:33:55PM -0500, Nishanth Menon wrote:
> I am esp concerned since there are platforms based on am62x and just
> 256MB DDR.

On that regard, currently you have reserved memory areas just before
512MB DDR limit. Any plan to move those?

Francesco

