Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044C07D06C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbjJTDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTDHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:07:17 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC4C2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=bit-b-5-s.net; s=ds202310; h=Content-Transfer-Encoding:Content-Type:Subject
        :From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RsVW5hKATVpDHunTZ7fG5wC8S8UTgTD2O4o7UoKH/Pw=; b=f/TJtOp60ZWBLP9JHLoTB1DJ1i
        39gCDBe4G1Fy5KPaHQDbNzyrGGhJqSvY3kbbiBeltFMENY3JgHVNEOjD8iDlzePS2uhEVWMKaMYe8
        hfJuEKP2urzHOfQxfdovu6WRm/J+RfAwMe31mrx1Uh9SWkr9FmxFRqsCYzAqhIP//9nKh8/QS4h/W
        CcTsoTN13fVah3kL3fUQLu+oRFLjhjsmzbT8Jv0xTTe16AYmebnra5Je6LQVp3gBZkE1ETcKHuMWF
        6FPZDmCTC24B2rDwfVytwG8gHb/+5XRUtw1C6vYJDSTkSqbypCCnGL0UsSJBnNrMpPR2GiuL6jwfG
        DC5r6cjw==;
Received: from [84.215.119.50] (port=52543 helo=[192.168.0.2])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <Ywe_C@bit-b-5-s.net>)
        id 1qtfqy-00Cj6i-Am
        for linux-kernel@vger.kernel.org;
        Fri, 20 Oct 2023 05:07:12 +0200
Message-ID: <bec1b7ee-bf9d-4bf3-8421-8a6ca11da562@bit-b-5-s.net>
Date:   Fri, 20 Oct 2023 05:07:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Ywe_C@bit-b-5-s.net>
Subject: Plan B (was low jitter, fair pay)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have reviewed all the data on this now, and here is a final conclusion.

Plan B was a project to continue Plan 9, that continued Unix.

I think this is the most correct perspective and to respect the legacy 
of all this.

Updated my blog post: https://bit-b-5-s.net/low-jitter-linux/

The Serene Be With You.
