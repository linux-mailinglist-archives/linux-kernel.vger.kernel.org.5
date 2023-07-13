Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20A87515B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjGMBGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGMBGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2159E;
        Wed, 12 Jul 2023 18:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDF8C619B9;
        Thu, 13 Jul 2023 01:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFE2C433C8;
        Thu, 13 Jul 2023 01:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689210369;
        bh=C4zO11G5b5oTT0GgOgcpMDulSVvYyRvx86jsQS9fQTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jd5k6fbDdWRMEuLUElYY2tr22GR1I4MLHVTOLYyvTB5NNrK0l11vQR5rPxASPZpjS
         f/dxxXZgpe5RX66mKDnunwUlPxBF7l8MQKzl0st9F3Q9iwCs9XfvYqyyZd7e0PeRKV
         8FO8i09hHY65Z3o3PtTNVz/I2aklh4AJA8h5sElP6ruIW8WjDxqVDOGU4rdue63sh1
         i6mIdkDy4xUAeIfugHgvGh1ftNItn67t+JP+UlHGuugIFDy+/qExVl4mf6abxHZUFz
         ELA0C6nwB1clTXpEELtpD+/2YHpuL5DwKgA2dooN7xn/EVpOGFMKFo+JLuEqCqjSg+
         T4vMDYsQ7W5Xw==
Date:   Wed, 12 Jul 2023 18:06:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     pkshih@realtek.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw89: debug: fix error code in
 rtw89_debug_priv_btc_manual_set
Message-ID: <20230712180607.67f471ab@kernel.org>
In-Reply-To: <tencent_D22D1FB0000F210538D44A09AA9BB6DAB407@qq.com>
References: <tencent_D22D1FB0000F210538D44A09AA9BB6DAB407@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Jul 2023 17:59:06 +0800 Zhang Shurong wrote:
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

No empty lines between the tags, please.
