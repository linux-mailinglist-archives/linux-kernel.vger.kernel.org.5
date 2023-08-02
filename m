Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03C76C74B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjHBHpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjHBHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:44:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFFBA4497;
        Wed,  2 Aug 2023 00:42:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0CEBE80AE;
        Wed,  2 Aug 2023 07:42:32 +0000 (UTC)
Date:   Wed, 2 Aug 2023 10:42:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3: Fixup remaining pin group node names
 for make dtbs checks
Message-ID: <20230802074230.GA14799@atomide.com>
References: <20230802040347.2264339-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802040347.2264339-1-nm@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230802 04:03]:
> Fix up outstanding pingroup node names to be compliant with the
> upcoming pinctrl-single schema.

Thanks looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
