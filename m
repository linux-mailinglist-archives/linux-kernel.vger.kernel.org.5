Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE0A7B132E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjI1GhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1GhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:37:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C459C;
        Wed, 27 Sep 2023 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wfjzeanupPjnEhAnbnxHI+LD+nLIbu+E90hTrqZ35hM=;
        t=1695883020; x=1697092620; b=kyCCYOAcZHre0t23IB5F9LlfIu2edcFgE9N9hwjxkuHYitx
        cGWRO/y28ntV4+r6u45qgoh+gDQ9F7Kd5RsMk54DeDE3Mx62KnJBiw3/pVLHFzf6RutYFNU8esTZf
        17zll0oAHFsS4nQ87z3Pt+ynXrCnZGBK7HE9Lv8G/nY9ZVQOJ0tGg5/1jVhAwSQS7KV0muROFrt1+
        PxSNzv7FuJTJj4hXnNdWbGNApmZ0CQbXobhUN/19GzpYhAdwT1Wviocaqip4xGQaZFiIeYkwZRCz2
        kTrRH/Ty32UnHSRO+ctc1ZEFNPTQ2MbClcJJIMWOf7RAOFYqOtUzvlkJLk0f7ANA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qlkda-009K7X-1f;
        Thu, 28 Sep 2023 08:36:38 +0200
Message-ID: <fd1265994629dc8719d3361a7343f09b775f3a55.camel@sipsolutions.net>
Subject: Re: [PATCH] wext.h: Clean up errors in wext.h
From:   Johannes Berg <johannes@sipsolutions.net>
To:     KaiLong Wang <wangkailong@jari.cn>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Sep 2023 08:36:36 +0200
In-Reply-To: <7c5744ca.8aa.18ad9c22e75.Coremail.wangkailong@jari.cn>
References: <7c5744ca.8aa.18ad9c22e75.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 11:08 +0800, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
>=20

Please do these things on staging, there really is no reason to touch
this decades-old code for such a thing now.

johannes
