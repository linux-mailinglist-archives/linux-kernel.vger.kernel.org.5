Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE879E946
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbjIMN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbjIMN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:27:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D67819B1;
        Wed, 13 Sep 2023 06:27:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543BBC433C7;
        Wed, 13 Sep 2023 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694611646;
        bh=tofNiE93U3IaqeBAYFxACX+5De+6Y1VRyuvZ5K22Ag0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EO9WY8KJHPsM2QmuPdVtf+Wu9sc//W8+E9ReFVCsnXq80hDJiv6ZLwYGMZjbAveI2
         EG/+UtJ8DClVKi5dqsIDPNTPfHiRTrTQfKtYrIwMEgMlI0n6OIlB8DscP/kUjAS1lB
         6HLfjNVN0QMgvxoLIudSH+m1JRoLfjt87ZJkjY2gMMr6I2zJkBKnnk7jzLIELPsuZb
         4Imde23QiiVGfyO5/r61n9cGMIGA6z6tJcsyVBqLpF12DZhDdch2yNVLSz8XgD0xpS
         VSrSn2829uaB1JQTpe2eKfqc2lMPORxZ8On42Uf7rcAlduwdm951rX2X5H2O8+JplE
         PXRqN7d070nFA==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [-next v2 1/2] riscv: dts: starfive: visionfive 2: Enable usb0
Date:   Wed, 13 Sep 2023 14:26:49 +0100
Message-Id: <20230913-hybrid-passerby-606345c74a14@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829020511.26844-1-hal.feng@starfivetech.com>
References: <20230829020511.26844-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=406; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=kN8TZYfWHNsAZO+4+tMUbkf2PgLIm9b2uFw6FtgFYC4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmMO6Zt+LYy+h2PteQ99qDdC5Rvvv/ItPP2jFuTuOa6C L4+cWHXs45SFgYxDgZZMUWWxNt9LVLr/7jscO55CzOHlQlkCAMXpwBMpGEuI8ORehleed9tzSpL HTiVF7U+mPtbJdjpQSjTk4ulbysnLWFnZLjhVfM+tmP++XtFSa87pvUEqacFtk8sErT5n5N3RDV 1KRsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 29 Aug 2023 10:05:10 +0800, Hal Feng wrote:
> usb0 was disabled by mistake when merging, so enable it.
> 
> 

Applied to riscv-dt-fixes, thanks!

[1/2] riscv: dts: starfive: visionfive 2: Enable usb0
      https://git.kernel.org/conor/c/2f9f488e7b14
[2/2] riscv: dts: starfive: visionfive 2: Fix uart0 pins sort order
      https://git.kernel.org/conor/c/1558209533f1

I'll try to get these out before the weekend, the other pending patch
has been sitting since mid merge window.

Thanks,
Conor.
