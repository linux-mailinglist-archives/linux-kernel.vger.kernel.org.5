Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C47AA811
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjIVFF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIVFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:05:24 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C5192
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 22:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit8.no;
        s=ds202309; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6Od13/3fA9p6r3To7pH1NWJ/wZE5gax46uKKnGwYrU0=; b=GXmtp+KWJSEM2gVG6mCKhyrgMQ
        HbmsqEwRMwL8xZgZW7K2IObcZLKzB3VfDCvUzq3kVAshSdcuXUrZzc7loQB1mvyKJBdE2gPnJKDz5
        yfKt6qYFRRcEwVI5KwzTQ1V80PIj5KuKRzUXdwS69Ujo49h8IK+RWBhd/U6FZWmWbv6kKBRRpnFq2
        4piFyFzvqEr0RUJE3fpQSe36IxOFHd3xHhxKUwd4SitKT2+G8Zjd8c0FJo4kxwesKsbUBlX0Gm0+1
        6UASC9tiP9oFjCmRo4wvEFXk/BFRX0Evf+nUp8mG11SL/frRVnkcDKP6sm0htrfAUz38qD7B2NOfC
        J8ohncfw==;
Received: from [84.215.119.50] (port=62593 helo=[192.168.0.2])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <Yca@bit8.no>)
        id 1qjYLr-00F4YU-8A
        for linux-kernel@vger.kernel.org;
        Fri, 22 Sep 2023 07:05:15 +0200
Message-ID: <d6a24c1b-872c-42e6-8100-ddaa39782f44@bit8.no>
Date:   Fri, 22 Sep 2023 07:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Yca@bit8.no>
Subject: Open Source X unification under TAHZIHN?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I talked about how TAHZIHN is a concept of The Gyad that unifies SIDH 
related efforts in computer design, and ZINH related designs in electronics.

And how openSUSE was closest to a OS effort under TAHZIHN.

But why not try to unify all Open Source efforts under TAHZIHN?

Open Source X would be this.

I made a little logo and post on my blog about this: https://bit8.no/?p=240

Compared to openSUSE, I would have tightened it up with this logo. (They 
lizardlicking theme of openSUSE probably confuses people.) And a low 
jitter kernel for smooth operation. I would also use the Oswald Google 
Font here (as on this site).

Peace,
Ywe.




