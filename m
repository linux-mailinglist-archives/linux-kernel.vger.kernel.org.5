Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B208B7B8A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244393AbjJDSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244382AbjJDSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:33:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB0C1;
        Wed,  4 Oct 2023 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=toVucifvQkY3aRDPKTi6NGRl7yNtpQ93dM9FsQF5b5k=;
        t=1696444404; x=1697654004; b=EIoPFwXt5oTwUQwrqKKOzqOiHzA73brakbDS6satqXew/4T
        gMis8cWEk4Xhe7BRv6yFeQejyED5KdWpJZ1PVjujFKA4yrsRRtKjxiqhskD+t5VnY4i/T6C6DfpPn
        mzW5/aPG5a1hyhzTeo5bjbVxZwV7tLZitnRDjwGVTssAl609apei18tMkWDdEYG06kGb2eFKNRS8B
        Uzgi2SnkJbIVK5MwftkEDb4D8y8qhFGr5ZwW+S9kPNgCZnd/sNtdyV1Xu/pIqIPGzey0Ge4lS8uCn
        krHUYTNCmdKjQJMgr+9anUON0iEs2KOmiG02KY9KwmcabIcxFO6sOFTTydOZ750A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC0)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qo6gS-00000004PQg-1SQ1;
        Wed, 04 Oct 2023 20:33:20 +0200
Message-ID: <58214dab3b0932a7ea2809df25aa31a242c7a72b.camel@sipsolutions.net>
Subject: Re: [PATCH] wext.h: Clean up errors in wext.h
From:   Johannes Berg <johannes@sipsolutions.net>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Oct 2023 20:33:19 +0200
In-Reply-To: <7c5744ca.8aa.18ad9c22e75.Coremail.wangkailong@jari.cn>
References: <7c5744ca.8aa.18ad9c22e75.Coremail.wangkailong@jari.cn>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the record, the sender address bounces.

johannes
