Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF97D06C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjJTDIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjJTDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:08:45 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D71A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=bit-b-5-s.net; s=ds202310; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RsVW5hKATVpDHunTZ7fG5wC8S8UTgTD2O4o7UoKH/Pw=; b=QLAAWz064dN7B3cNYPH62b5noh
        j20zybGmubwOzzXgaIWioQSReUghxpf1qlVEM6xQFg/1r8SZcF6S4EN2JM7iVrdSwxlz4SrdiSqAr
        yxk2UDT1otQiV4MOdOWpUl36+/jL9Rt81CCoRjnbqtfRk7opDfvNIkCaoE2f/+v6QnMhdGO2s9Dm2
        HihQZzGcQqxHi0oCgqPYOVSB79ZIAow6fqfXyDeVGnvTaziAJI4ppjIF01SdtSu5H/SaB7zdAVR+G
        211u0zG3Kt8BeVjkLmM2nD04myTwfVl2jhYgtJpe8UZE97AlwXypjDkCktjWQkhnk2oafluezQ/m8
        GmTl+bnw==;
Received: from [84.215.119.50] (port=52543 helo=[192.168.0.2])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <Ywe_C@bit-b-5-s.net>)
        id 1qtfsQ-00Cj6i-2S
        for linux-kernel@vger.kernel.org;
        Fri, 20 Oct 2023 05:08:42 +0200
Message-ID: <005dacbe-b62b-42a7-aba8-9fcf9ec6146c@bit-b-5-s.net>
Date:   Fri, 20 Oct 2023 05:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Plan B (was low jitter, fair pay)
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Ywe_C@bit-b-5-s.net>
To:     linux-kernel@vger.kernel.org
References: <bec1b7ee-bf9d-4bf3-8421-8a6ca11da562@bit-b-5-s.net>
In-Reply-To: <bec1b7ee-bf9d-4bf3-8421-8a6ca11da562@bit-b-5-s.net>
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
