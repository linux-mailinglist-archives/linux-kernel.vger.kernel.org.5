Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2B789CD4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjH0Jt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjH0Jtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A8D110
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9766F62B2E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C49C433C7;
        Sun, 27 Aug 2023 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693129789;
        bh=NN4bF4fY8JwEW6Rjtb55IoHjAtxKuNE9Mm+BDXzOo6Q=;
        h=Date:From:Subject:To:Cc:From;
        b=PUi/coDWWpt1mY/QF4ajF04B91ZqcHkucBS9QGzMcAvoqkhSwIrZ8GIzCWpLYa9EU
         mTo6bMUEa6skFnCrOUa+kZJNb38u7wwvGqtGbNv2DU+C6YYMiObsFBgPEiN+K1B/T2
         zDKawLrcgiMg3JSrTvkm14K3rvv3A78kD2wLL3tpwsd+eiWOD7P1gkjNLdD/60zWPR
         N2FZGK9RZxhFzxiOyYYFivd2kEXCxbN3Qk4qITlw0V/RIX9UykvdMqy4dWVCZiW8Vt
         ThcVIfTLzED66YBR5TauRFGHVHOdugFcxLAxBoqVOfSi2+xCnCz/v2PUghuim9koR6
         2/htvfK27ZgHw==
Message-ID: <3929a597-6a83-ed30-ad15-9e4404373374@kernel.org>
Date:   Sun, 27 Aug 2023 11:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: [NFC/neard] neard release v0.19
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        aur-general@lists.archlinux.org, devel@lists.fedoraproject.org,
        packaging@lists.opensuse.org
Cc:     Mark Greer <mgreer@animalcreek.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cody P Schafer <dev@codyps.com>,
        Dirk Mueller <dmueller@suse.com>, kokakiwi@kokakiwi.net,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

v0.19
=====
This is announce of new release of neard, an user-space counterpart of
Linux kernel NFC stack, v0.19.

I am sending this email to few distro lists and folks involved in
packaging neard (and updating existing packages). Please let me know if
I should skip notifying you or you think I should Cc someone else.

The release includes few fixes. Full changelog via Git, simplified changelog in:
https://git.kernel.org/pub/scm/network/nfc/neard.git/tree/ChangeLog?h=v0.19

Source code release:
https://git.kernel.org/pub/scm/network/nfc/neard.git/tag/?h=v0.19
https://git.kernel.org/pub/scm/network/nfc/neard.git/snapshot/neard-0.19.tar.gz

Best regards,
Krzysztof
