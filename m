Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8D802056
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 03:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjLCCNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 21:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCCNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 21:13:40 -0500
X-Greylist: delayed 1335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Dec 2023 18:13:42 PST
Received: from smtp-out2-webmail-7.u-picardie.fr (smtp-out2-webmail-7.u-picardie.fr [195.83.153.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DFB115
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 18:13:42 -0800 (PST)
Received: from passoire-02.vm.u-picardie.fr (passoire-02.vm.u-picardie.fr [10.0.132.142])
        by smtp-out2-webmail-7.u-picardie.fr (Postfix) with ESMTP id 4SjVC05YVHz404q;
        Sun,  3 Dec 2023 02:51:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at u-picardie.fr
Received: from smtp.u-picardie.fr ([10.0.132.227])
        by passoire-02.vm.u-picardie.fr (passoire-02.vm.u-picardie.fr [10.0.132.142]) (amavisd-new, port 10048)
        with LMTP id c-5mqIO72Tpy; Sun,  3 Dec 2023 02:51:17 +0100 (CET)
Received: from horde-ext-01 (horde-ext-01.vm.u-picardie.fr [10.0.132.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: s21904221)
        by smtp.u-picardie.fr (Postfix) with ESMTPSA id 4SjVBs1XkHz3x2l;
        Sun,  3 Dec 2023 02:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u-picardie.fr;
        s=smtp; t=1701568277; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type; bh=MCUt3h/M0huLpIWYMK/xPyXSS0PPIiso9w6bS4c62X4=;
        b=HN5MHjx2/API21J2bo86HKfAPCvHZsDXghxUMOP3kP2nwTYAvYYyBg0igVnNU70fqd0T1C
        28ztIQkp1W9OdeqLC5TuY+jiDk0BvckJV1AnOUWwSQ3CDFuDVNgP1U+pt+aaMDU4ANXsF6
        pYtRd10PoJF4U2FESTKiC1yaxm9+19ScZ5E7sAflfx60noyrIf8a5wxqYazGxxhtM/dwfc
        bnPri3tDZ6450kO1mOL7VLeGgQXv50160jL8de3QGwcy6OTG4nb6iMaYL2UxKAr5Hwmx0N
        0ojJyy7+ieHcITCx3vrI3fVhB8/KSu4xtirS/lJ/asVTFK+v2epHeqcNMTtooA==
Received: from dyn-as-mobile-154-160-9-229.mtn.com.gh
 (dyn-as-mobile-154-160-9-229.mtn.com.gh [154.160.9.229]) by
 webmail.etud.u-picardie.fr (Horde Framework) with HTTP; Sun, 03 Dec 2023
 02:51:17 +0100
Date:   Sun, 03 Dec 2023 02:51:17 +0100
Message-ID: <20231203025117.Horde.7j_MRf-lIAVCpRY3mKrNMcQ@webmail.etud.u-picardie.fr>
From:   Hammed Saleh <maxime.swiathy@etud.u-picardie.fr>
To:     info@hammedsaleh.com
Subject: Re : Adminstration
Reply-to: hammedsaleh07@gmail.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Bar: /
Authentication-Results: smtp.u-picardie.fr;
        auth=pass smtp.auth=s21904221 smtp.mailfrom=maxime.swiathy@etud.u-picardie.fr
X-Rspamd-Server: passoire-03
X-Rspamd-Queue-Id: 4SjVBs1XkHz3x2l
X-Spamd-Result: default: False [0.90 / 1000.00];
        FROM_NAME_EXCESS_SPACE(1.00)[];
        MIME_GOOD(-0.10)[text/plain];
        BAYES_HAM(-0.00)[27.49%];
        TO_DN_NONE(0.00)[];
        DKIM_SIGNED(0.00)[u-picardie.fr:s=smtp];
        MID_RHS_MATCH_FROMTLD(0.00)[];
        NEURAL_HAM(-0.00)[-0.977];
        MIME_TRACE(0.00)[0:+];
        FROM_EQ_ENVFROM(0.00)[];
        RCVD_COUNT_TWO(0.00)[2];
        R_RATELIMIT(0.00)[from(RLshhr57qsptnchny67xcqy8m4),user(RLoogm8cft8yzchm),user(RLapdx7kuga933n)];
        RCPT_COUNT_ONE(0.00)[1];
        REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
        FROM_HAS_DN(0.00)[];
        RCVD_VIA_SMTP_AUTH(0.00)[];
        HAS_REPLYTO(0.00)[hammedsaleh07@gmail.com];
        RCVD_TLS_LAST(0.00)[];
        FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com,fastmail.com,me.com];
        TAGGED_RCPT(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        FREEMAIL_REPLYTO(0.00)[gmail.com];
        ARC_NA(0.00)[]
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org









Confirm the receipt of my last message please

