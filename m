Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018DA7EEA51
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjKQA3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 19:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjKQA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:29:36 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D11129;
        Thu, 16 Nov 2023 16:29:29 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A85EC24DBD8;
        Fri, 17 Nov 2023 08:29:21 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Nov
 2023 08:29:21 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Nov
 2023 08:29:17 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <conor@kernel.org>
CC:     <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jisheng.teoh@starfivetech.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <will@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: perf: starfive: Add JH8100 StarLink PMU
Date:   Fri, 17 Nov 2023 08:28:30 +0800
Message-ID: <20231117002830.1762079-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116-paycheck-upstairs-8147b6137f7a@squawk>
References: <20231116-paycheck-upstairs-8147b6137f7a@squawk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 17:27:17 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Nov 17, 2023 at 12:23:30AM +0800, Ji Sheng Teoh wrote:
> > Add device tree binding for StarFive's JH8100 StarLink PMU
> > (Performance Monitor Unit).
> > 
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>  
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Generally, there's no need to submit new versions so quickly - you can
> wait for feedback on multiple patches before resubmitting the entire
> series.
> 
> Cheers,
> Conor.
> 

Sure, Thanks for reviewing.
