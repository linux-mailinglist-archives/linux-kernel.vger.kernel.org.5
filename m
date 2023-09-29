Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4BD7B3A79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjI2TRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjI2TRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:17:37 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Sep 2023 12:17:34 PDT
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796221B6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=1620; s=dkim-tub; t=1696015054;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=En/eyLIoaU92jRTbDeP+2Hidtf3TrZ2Oi5ACqqqEdlY=;
  b=fF6XtifnSU0a6YpTSjgq3nkD9xEsgEZgonPKx0zymgBXYyAjbOzVtTaX
   xKw/mcGZr02E+ve+53vWp3YVwBJIMWcxVm8lbkhwcdfsSNIpWKFEkbn1N
   5Dcj9QMI6phc+Wx8mUfuzEH3uGxNuH1wVB2vq+jBpUTToRziPi8sJeKMZ
   Q=;
X-CSE-ConnectionGUID: CQksel9ZRtiitpEjvYIyrw==
X-CSE-MsgGUID: WjIWLRGMTm6EV+vBOyog5A==
X-IronPort-AV: E=Sophos;i="6.03,188,1694728800"; 
   d="scan'208";a="5160520"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 29 Sep 2023 21:16:29 +0200
Message-ID: <bc1fe3c5-d2bd-4071-af1e-28ca4b3a697c@tu-berlin.de>
Date:   Fri, 29 Sep 2023 21:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Adrian_W=C3=BCthrich?= <adrian.wuethrich@tu-berlin.de>
Subject: Publication on communication structures
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Developers,

I am a researcher in history and philosophy of science at Technische
Universität Berlin.

I would like to inform you about an upcoming publication in which I
include a very short, anonymized network analysis of messages from this
list. The main topic of the publication, however, is the communication
structure of the ATLAS collaboration at CERN, the particle physics
laboratory. A draft of the paper is available at
https://tubcloud.tu-berlin.de/s/N9noYEfHqBLDtQq

For the short analysis of the linux kernel mailing list, I used the
messages sent during the year 2012 as archived on https://lkml.org/.

In the publication, I mention some global characteristics of the network
of messages and replies sent to the list – its density, for instance
(see p. 17). No email-addresses, nor names of persons, nor any content
of the messages will be published.

The paper will be published in "Synthese", a leading journal in the
philosophy of science, in the topical collection "Digital Studies of
Digital Science" [1].

If you have questions or comments concerning the publication, please
contact me at adrian.wuethrich@tu-berlin.de.

Kind regards,

Adrian Wüthrich

[1]: 
https://link.springer.com/journal/11229/topicalCollection/AC_1c4c69b0590f6e1f1e3f19cb34f7d769/page/1


-- 
Adrian Wuethrich
Technische Universitaet Berlin
Institut fuer Philosophie, Literatur-, Wissenschafts- und Technikgeschichte
Raum H 2534 / Sekr. H 23
Strasse des 17. Juni 135
D-10623 Berlin
adrian.wuethrich@tu-berlin.de
+49 30 314 24069
https://www.tu.berlin/go214591/
