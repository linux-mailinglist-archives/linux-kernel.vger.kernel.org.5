Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60F17770C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjHJGxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjHJGxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:53:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91C610F5;
        Wed,  9 Aug 2023 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dV0fS1M2Tqa/ji66e1+5uiGKbw4A0MVzF9K5dFXcc4U=;
        t=1691650421; x=1692860021; b=FNaLK8iuWWVLFdApVvXgNvwVt0unP9HfJrPI8lSCgIyn/zy
        zunDj3OAXcyBDRulXaRPi+k0SXaanq5W7MW2GDeDSlTFPmBeqlFnaxymZ4qB4f9sQqyCkBw9N5rE4
        4duo1JqjwfTdQdS5WDP4f7lLW2YOVQlCQd/8YKKn3TqyRaiBmfbNgatPGeCVbBMy4+0nCv/NEabE7
        4r3185sYJzU9g35B+O5i1IxDShxMqzP0gpc/U1rmlK7guNeAfRgpDt/u9sNAbcG4D4Vk7F3jgsky3
        mGoFUlDitnoPrHJs9sytQTsIO54J8JJVmv1IG4ZgCCSqWfFDWyMMlUytNVm5HmAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTzY2-00GJ9Z-1u;
        Thu, 10 Aug 2023 08:53:30 +0200
Message-ID: <5fcffcebca2ef9b8c276e5f4b4464d888649a70b.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: ralink: rt2x00: "foo* bar" should be
 "foo *bar"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, hanyu001@208suo.com,
        stf_xl@wp.pl, helmut.schaa@googlemail.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Aug 2023 08:53:29 +0200
In-Reply-To: <ZNRHCBbvEPtq-cE7@debian.me>
References: <tencent_316424AFC531C5F050C0203FDBA08E84F907@qq.com>
         <18520fa625b8a901314c65bb8e557091@208suo.com>
         <36e36d94e81da4342283aac471fb5a7bd3eb9f65.camel@sipsolutions.net>
         <bed853f70773496902b5676e568922edbf487dfb.camel@sipsolutions.net>
         <ZNRHCBbvEPtq-cE7@debian.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-10 at 09:10 +0700, Bagas Sanjaya wrote:
> > And the email address doesn't even work, only about two weeks after you
> > sent this patch?
> >=20
> >   hanyu001@208suo.com
> >     host mx1.qiye.aliyun.com [47.246.146.58]
> >     SMTP error from remote mail server after RCPT TO:<hanyu001@208suo.c=
om>:
> >     554 RCPT (hanyu001@208suo.com) dosn't exist
> >=20
>=20
> No wonder why @208suo.com people ignore reviews from mailing list - their
> addresses are send-only without real mailboxes...
>=20
> BTW, how can you get above error message? I'm curious.

That was just the error message I got back from my mail server,
presumably now that you actually tried emailing them, you also got one.

I'm beginning to think we should just block that whole domain until
someone there is actually willing to _interact_, not just throw
(garbage!) patches over the fence.

johannes
