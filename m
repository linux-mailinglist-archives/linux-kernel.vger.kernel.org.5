Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA78757349
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGRFlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGRFlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:41:05 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB98E43;
        Mon, 17 Jul 2023 22:41:03 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aefe8.dynamic.kabel-deutschland.de [95.90.239.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6E15F61E5FE01;
        Tue, 18 Jul 2023 07:40:38 +0200 (CEST)
Message-ID: <41f91e8e-8038-22d8-baa6-91f98afe405d@molgen.mpg.de>
Date:   Tue, 18 Jul 2023 07:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
To:     Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-bluetooth@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
References: <20230718034337.23502-1-jlee@suse.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230718034337.23502-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chun-Yi,


Thank you for your patch.

Am 18.07.23 um 05:43 schrieb Lee, Chun-Yi <joeyli.kernel@gmail.com>:

[…]

> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

As checkpatch.pl also reports, please make sure the author and 
Signed-off-by entry match.

     $ git config --global user.name "Chun-Yi  Lee"
     $ git commit --amend --author="Chun-Yi Lee <jlee@suse.com>" -s

(It’s also common to write the name in the order, so no comma is needed.)

`git format-patch` should not generate a patch with a dedicated `From:` 
at the beginning, so you can send it from a different email account. (No 
idea, why upstream Linux kernel development shouldn’t work with your 
SUSE address.)


Kind regards,

Paul
