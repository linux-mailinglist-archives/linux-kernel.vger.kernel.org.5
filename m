Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5979768A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbjIGQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjIGQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:11:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B628518A;
        Thu,  7 Sep 2023 09:08:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387EUMEN012475;
        Thu, 7 Sep 2023 09:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694097022;
        bh=iizL7oHkzdtUKafgy+23NXIf5F01F0/spqcKBDyXeVQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ByyPNf+GgYBrJIgydC7bWdsAj4rOO6PTcSDl88YbvbE3oTr4so4jvcAfYbrISRyrX
         Bb+SnLGUlkGuerf3azo87d6eemLLqf+/yeLrO2akFC1qv2tb2HPUfqzFkXiwrXmK5U
         ltt8ZIpAhFo7PeTcuqfXuC511zp1ZGyEXA1hFpek=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387EUM7L016064
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Sep 2023 09:30:22 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 09:30:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 09:30:21 -0500
Received: from [10.249.131.134] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387EUHim010301;
        Thu, 7 Sep 2023 09:30:18 -0500
Message-ID: <e0b6ddeb-7129-d76f-0584-112d79e3a1fb@ti.com>
Date:   Thu, 7 Sep 2023 20:00:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/7] arm64: dts: ti: k3-j784s4-main: Add the main
 domain watchdog instances
Content-Language: en-US
To:     "Kumar, Udit" <u-kumar1@ti.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <rzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230907115210.28082-1-j-keerthy@ti.com>
 <20230907115210.28082-5-j-keerthy@ti.com>
 <19f9895f-0975-713e-f2eb-fd5e16d6fb98@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <19f9895f-0975-713e-f2eb-fd5e16d6fb98@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,EMPTY_MESSAGE,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


