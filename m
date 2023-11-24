Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A607F8495
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbjKXT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXT2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:28:06 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118B130EF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=su-phil.net
        ; s=ds202310; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Cpg0nVksfojYA23UF3HaSNME2AMLYi+y+EWCvSTQDF4=; b=LZSiJgAYucHr4jjbUijKL33c5d
        ROm1wYNGrdLLPb3Yt7lPBUfdf7DKuBSfW9ZXMgwwJ5EG6mnSiA49pABlCl05trrFz8pU/HDDtk3wZ
        2QABw9E3+UjRRpEBqKauJz01ORrFIgLOpgyNWCkovwMChiwdyl6ioRfQcmW8D+jAAPTEGckD1QS84
        //2U8m4KkSsE65mjxCm/baFFwkaLTp0NTY9YWeXiqPYEybnZy79rNVOTGxvvcok++o0GCNhFbtnGi
        /8VPfaVKkBzrm/8EO3lN5ZXR9OGo/+9sRrEJFYfa6OO2zoooNsCbWFXSSa6TGRD0QHtZW+7Mgvpfn
        dRf2QP+g==;
Received: from [84.215.119.50] (port=56385 helo=[192.168.0.2])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <Ywe_C4rlyn@su-phil.net>)
        id 1r6bqU-007KHB-LR
        for linux-kernel@vger.kernel.org;
        Fri, 24 Nov 2023 20:28:10 +0100
Message-ID: <51038ccc-ebad-4f04-9489-76d1d68eaaa7@su-phil.net>
Date:   Fri, 24 Nov 2023 20:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Ywe_C4rlyn@su-phil.net>
Subject: @ X (was low,jitter, fair pay, naming schemes etc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the optimal symbol actually is instated a long time ago, in @.

So naming and design guidelines can simply be reduced to @ X.

It actually is placed on Youtube, symbolically being the only thing that 
matters there, so it should work.

-Peace.
https://www.youtube.com/@ytb_muz/videos
