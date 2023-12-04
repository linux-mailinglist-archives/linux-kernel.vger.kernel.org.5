Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDA802C15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjLDHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDHdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:33:44 -0500
Received: from shmail0.sohard.de (shmail0.sohard.de [87.140.57.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC65D7;
        Sun,  3 Dec 2023 23:33:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by shmail0.sohard.de (Postfix) with ESMTP id 4B8CBBE08E2;
        Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
Received: from shmail0.sohard.de ([127.0.0.1])
 by localhost (shmail0.sohard.de [127.0.0.1]) (amavis, port 10032) with ESMTP
 id 0d81F8dSAOyK; Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by shmail0.sohard.de (Postfix) with ESMTP id 1CE7ABE08E3;
        Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at shmail0.sohard.de
Received: from shmail0.sohard.de ([127.0.0.1])
 by localhost (shmail0.sohard.de [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Mg7LYY86eXRO; Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
Received: from [192.168.178.40] (p5b111cfc.dip0.t-ipconnect.de [91.17.28.252])
        by shmail0.sohard.de (Postfix) with ESMTPSA id C926FBE08E2;
        Mon,  4 Dec 2023 07:33:47 +0000 (UTC)
Message-ID: <19011a70-7932-4773-ac1d-ac1459400728@sohard.de>
Date:   Mon, 4 Dec 2023 08:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arcnet: restoring support for multiple Sohard Arcnet
 cards
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231130113503.6812-1-thomas.reichinger@sohard.de>
 <20231201200514.1b0b55a1@kernel.org>
From:   Thomas Reichinger <thomas.reichinger@sohard.de>
In-Reply-To: <20231201200514.1b0b55a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yes, commit 5ef216c1f848 introduced a bug

Am 02.12.2023 um 05:05 schrieb Jakub Kicinski:
> On Thu, 30 Nov 2023 12:35:03 +0100 Thomas Reichinger wrote:
>> commit 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")
> 
> Fixes: 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")
> 
> right?

