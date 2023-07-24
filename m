Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9375FDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGXRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:31:25 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBBE5C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:31:20 -0700 (PDT)
Received: from [193.138.155.172] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qNzOo-0007DK-98; Mon, 24 Jul 2023 19:31:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Diederik de Haas <didi.debian@cknow.org>
Cc:     linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] nvmem: Kconfig: Fix typo "drive" -> "driver"
Date:   Mon, 24 Jul 2023 19:31:09 +0200
Message-ID: <4647834.PYKUYFuaPT@phil>
In-Reply-To: <20230724113622.12838-1-didi.debian@cknow.org>
References: <20230724113622.12838-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. Juli 2023, 13:36:22 CEST schrieb Diederik de Haas:
> Fix typo where "driver" was meant instead of "drive".
> While at it, also capitalize "OTP".
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



