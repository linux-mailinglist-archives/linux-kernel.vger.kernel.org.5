Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A67F6117
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbjKWOIg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 09:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbjKWOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:08:34 -0500
X-Greylist: delayed 1866 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 06:08:38 PST
Received: from email.solokkota.go.id (unknown [103.84.209.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A4B91;
        Thu, 23 Nov 2023 06:08:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by email.solokkota.go.id (Postfix) with ESMTP id 5E10F31E54C0;
        Thu, 23 Nov 2023 13:30:23 +0000 (UTC)
Received: from email.solokkota.go.id ([127.0.0.1])
 by localhost (email.solokkota.go.id [127.0.0.1]) (amavis, port 10032)
 with ESMTP id b1cvuBiAu203; Thu, 23 Nov 2023 13:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by email.solokkota.go.id (Postfix) with ESMTP id 640BD31E5331;
        Thu, 23 Nov 2023 13:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at email.solokkota.go.id
Received: from email.solokkota.go.id ([127.0.0.1])
 by localhost (email.solokkota.go.id [127.0.0.1]) (amavis, port 10026)
 with ESMTP id h2e_Ks1Cagui; Thu, 23 Nov 2023 13:30:22 +0000 (UTC)
Received: from email.solokkota.go.id (email.solokkota.go.id [103.84.209.203])
        by email.solokkota.go.id (Postfix) with ESMTP id 26D6A31E54C0;
        Thu, 23 Nov 2023 13:30:14 +0000 (UTC)
Date:   Thu, 23 Nov 2023 13:30:14 +0000 (UTC)
From:   =?utf-8?B?INCh0LjRgdGC0LXQvNC90YvQuSDQsNC00LzQuNC90LjRgdGC0YDQsNGC0L7RgA==?= 
        <dispar@solokkota.go.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <1925319478.19206.1700746214090.JavaMail.zimbra@solokkota.go.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [103.84.209.203]
X-Mailer: Zimbra 8.8.15_GA_4562 (zclient/8.8.15_GA_4562)
Thread-Index: oLeSqT9nGw9FaIfl6l1CS9AWSmnzDQ==
Thread-Topic: 
Content-Transfer-Encoding: 8BIT
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        RDNS_NONE,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,TVD_SPACE_RATIO_MINFP,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [103.84.209.203 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.0 TVD_SPACE_RATIO_MINFP Space ratio (vertical text obfuscation?)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ВНИМАНИЕ;

Ваш почтовый ящик превысил ограничение хранилища, которое составляет 5 ГБ, как определено администратором, который в настоящее время работает на 10,9 ГБ, вы не сможете отправлять или получать новую почту до тех пор, пока не проверите почту почтового ящика повторно. Чтобы повторно проверить свой почтовый ящик, отправьте следующую информацию ниже:

имя:
Имя пользователя:
пароль:
Подтвердите пароль:
Электронная почта:
Телефон:

Если вы не можете повторно проверить свой почтовый ящик, ваш почтовый ящик будет отключен!

Приносим извинения за неудобства.
Проверочный код: en: WEB. АДМИНИСТРАТОРА. RU006,524765 @2023
Почтовая техническая поддержка @2023

Спасибо
Системный администратор.
