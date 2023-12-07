Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF400808B92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443380AbjLGPPp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 10:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjLGPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:15:43 -0500
Received: from lhr.gtn-esa2.in (gtnesa2.ptcl.net [59.103.87.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98F3A19A;
        Thu,  7 Dec 2023 07:15:46 -0800 (PST)
Message-Id: <573856$1ia2tj@lhr.gtn-esa2.in>
X-IPAS-Result: =?us-ascii?q?A2FzDgAb33Fl/9t3sbYNTYEJCYFIgU8CkDCgfjs4hH5Wg?=
 =?us-ascii?q?X0PAQEBAQEBAQEBHRMdBAEBhQEDAocuJzwCDQECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEBBQEBAQEBAQYDAQEBAoEZhS+DBYQOfSiBFrJ4eIE0GmeEX7F6AwGIDAGFW?=
 =?us-ascii?q?IQ2j3+CUwSDY5wgBwdwR3AbAwcDfw8rBwQwIgYJFC0jBlEEKCEJExI+BG2CR?=
 =?us-ascii?q?Qp/Pw8OEYI+YTYZSIJbFQw1SnUQQheBEW4bEh43ERIXDQMIdB0CMjwDBQMEM?=
 =?us-ascii?q?woSDQshBVYDRQZJCwMCGgUDAwSBMwUNHgIQLCcDAxJJAhAUAzsDAwYDCzEDM?=
 =?us-ascii?q?IEZDE8Dbh82CTwPDB8COQ0nIwIsVgUSAhYDJBo0EQkLKAMvBjgCEwwGBgleJ?=
 =?us-ascii?q?hYJBCcDCAQDXQMUAzMRHTcJA3g9NQgMG0xHHRKlYkCBUol1mjhpoEsHAwuEB?=
 =?us-ascii?q?KVHAZNeA5I2hiuGPotZIKpJgWiDWwEBS1GiWoEQAgcLAQEDCYkigUABAQ?=
IronPort-PHdr: A9a23:Inc18RdiVQGOCnLx5IguezENlGM+MdnLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWZG9yLsLkc2qL/iOPJZy8p2dW7jDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajYr5+N
 gi6oAbfu8UZnYdvLrs6xwfUrHdPZ+lZymRkKE6JkRr7+sm+4oNo/T5Ku/Im+c5AUKH6cLo9Q
 LdFEjkoMH076dPyuxXbQgSB+nUTUmMNkhpVGAfF9w31Xo3wsiThqOVw3jSRMNDsQrA1XTSi6
 LprSAPthSwaOTM17H3bh8pth61cvB+sqQBzz5PNbI2JKfZ1Y6fRcc4aSGZEWMtaSi5PDZ6mb
 4YXE+UOMulWoZTjqVUOsxawCxOsCfjzyj9RmnP6wbE23/g8HQzAwQcuH8gOsHPRrNjtOqsfT
 +C1zLPJzTXYdf9YxTnx45XPfx09u/GMXLxwfdDUx0kvDQzFiE6dqZT5PzyJ0uQBqW6b4PR8V
 e61k24nqBh8rz6yzcgjlofHnJgaykzY9Spn2oY1I8W1RU9mbdK6H5Vdty+XOpdqTs4hTWxmt
 iU3x70Jt5OnYCQHx4oqygDDZ/GGb4WF7RzuWuiMLTp6mX5oeayyigu9/EWm1+byVdG03U5Xo
 idGjNXArG0B2h7R58SdV/dx40Os1SyR2wzO7uxJJ10/mLfBJJE83rA/iIITsVnfHiH4n0X2i
 bWZdkQi+uWw8+TnfqnpppuGO49ylA7+Lr4imtS8Aek+LwMDQWyb+fmn1L3/40L5WqhEjvw3k
 6bHqJ3XK9oXq6y/DgRIyIgs8Qy/AC2j0NkAmHkHK09KdwyfgojyPlHOPOj4DfCig1SwiDtrx
 +7JPrnmApjVKnfOlKrtcax55kJC0gY/09BS649OBrwCIP/8XFf9tN3eDhAnLwy52/vrBdZj2
 o8ERG6CAK2UPLnPvVOV4u8jOfeAaJIRtTrlLvgq/f/ujXs3mV8Heqmp2IMaZWyiHvRnLUWVe
 3/igtcbHmcMpQc+VPDqh0GGUTJJYXa9Qb486isjCIKlFYvDQJuij6Sb3CinBp1WenxGCleUH
 Hv2d4iIQ+0MZz6KIs99jjwEUqCsS4sg1RG2qA/6zLxnLuXO+iIGupLuz9h06PfTlRE18jx4F
 diS02aIT21shGMHWyc23LxjoUx60lqD1al4g+RFFdxQ+f9FThs2OJ/Hwu16Ed/yWgXBftCTR
 Fm6RdWmBCk9TsgtzN8Wf0Z9B9KigwjH3yqrG78Ul6aEC4Ev/6LT2nj+Pcd9y3Lc2KY9iFkmR
 9NDNXe6ia5n6wjTG4nJnl2fmaipbqoS3zLA+n+Cw2WWsk9XXhJ9X73eUHEffETWrdP55kTYQ
 7CyDrQnNxdOxtSGKqtOctHpl0lJRO//ONTCZGK8g2OwBReRxrONcYrremUd0T7SCEgBiQ8T/
 HKGORIiCSempmKNRABpQBjzJUbl6/RvoXayZklxyh2HZAtq0Py34lRd0dWGSv1V/bINvg85t
 z5wWlCww5TOCIzTnQd5eLRgZoY24E1GzifDtwtxM4eIJLhkwF8CICptuEa7nT53EIRb1/Jg5
 CcD1gt8b4GY2VVpby+T2db2N6GRMmqkr0PnULLfxlyLiIXewawI8vlt8giLgQ==
IronPort-Data: A9a23:kxnamao2Jhaa156PsLIPnHig23BeBmJ6YhIvgKrLsJaIsI4StFCzt
 garIBmAM/vZN2Kgeop0bIXipB4B7MLWzYUwHVZk+CgyQXwTp5acVYWSI27OZC7DdceroGCLT
 ik9hnssCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo93bZl6mJUqYLhWVjU4
 4ut+5S31GKNglaYDEpFs8pvlzsy5JweiBtA1rDpTakW1LN2vyB94KM3fcldHVOhKmVnNrfSq
 9L48V2M1jixEyHBqD+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRa1hIg+ZzihxrhMJ
 NtxWZOYGAYlOPGdpvYmWBBXGD1ZYv1mo47pGC3q2SCT5xWun3rE8KQ3ShBse9dFo6AnXFQmG
 f4wcWBXKEnc2KTvmeP9ELA97iggBJCD0Ic3k2thw3f6Df8gaYjfSKGM49JEmi8z7ixLNauEO
 JdINWU3BPjGS0VKGUlJFJYVpeixqyLCURx3uX/L4pNitgA/yyQ0itABKuH9ft2SWcJTkVyVq
 UrX9mT+BVcRM9n34T6E6m+v3LeXwwvqUYIVE/uz8fsCqFmS3n0aBDUZUFK6pb+yjUvWc/Z+E
 m093AUZgZUb0mS6R9n6WFuzp3uPtxoYM/JUEvQ79RON4qXR6gedQGMDS1ZpbN0/qc46Tjwr0
 lPQx4rBBTtztbSUTTSW8bL8hTezIDUUIWALYSYUXA8M6fHspYgyilTESdMLOKq0l8D0FTT93
 zmOojgWiLAajMpN3KK+lXjDgiuxp5TVSQI89y3YW2uk6kVyY4vNT4ip81HQ9/tMLZqxQVyIv
 XxCkM+bhMgKDIuMnSOPQeEEGpmp4OqAOTzYx1VoGvEJ0zW3+nesf4FU6TcnfG9pNdoBcD7tJ
 kTUvGt54J5JPXKxYKl6S4K2F8EjzKymHtPgPtjQb8BPbpR2cgCO5yFvTUGV1mHp1kMrlMkXP
 ZaBcMqrC14QDblq0zuwAewduZcvxzo/yWTVbZP8zx3h17eCDFaRSK0EPFyIRuQw87KJukPe9
 NM3H8+L0RRTV+vWeTHN8IgPaEsNKWUnBJfwsIpccevrCg5nAmAtDPmUmO0Je4t5mq1UkqHD+
 XTVcmtZ0lvzgnuCKgyPZ2pkbLfudZZ4sXcyPChqNlGts1AnYJyu4KAZMcYfe6Qj8Oxk0ft9T
 v1DcMKFatxLSy7G9zMbK5DysZdidTyrgh6LNiuhJjM4evZIQw3T+9PjeE3l+TMPFSq+ndY4o
 vi4zEXWTYdrbyBjFsfab/Tp406qvXkWkcp8Qg7CL8NXeUOq/IUCAyjwlP47JMdKJhzYxjqy1
 wGKBB4Zoa/GpIpdzTXSrfnU9cHwTLQ4RxMLWTOCvN5aKBXnw4Zq+qcYOM7gQNwXfDicFHmKD
 Qme8x0w3DDrUrqHX0qQ3ouHFZ4D2uY=
IronPort-HdrOrdr: A9a23:WXPxiKlJShN9wZXmLFBbuK00IkTpDfI83DAbv31ZSRFFG/FwWf
 rPoBzTvSWZtN93YhwdcLG7U5VoLkmslqKdjbNxAV7AZmPbUQKTRelfBO3Zsl/d8kbFmdK1u5
 0PT5RD
X-Talos-CUID: 9a23:X69Flm2GaCB81S8QvomZGrxfS8EpdCGM8mXrKEa3AnpOF+21Em6+wfYx
X-Talos-MUID: 9a23:Mus1bwiIe+ur2/5c/YA1n8MpbMJL/fqyDGs0nowr4PSmFANhFmnatWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,256,1695668400"; 
   d="scan'208";a="52759475"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO [91.92.251.85]) ([182.177.119.219])
  by lhr.gtn-esa2.in with ESMTP; 07 Dec 2023 20:15:27 +0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Approval
To:     "t.maruyama@n-mtec.co.jp" <Arif.Khan@ptcl.net.pk>
From:   "Chris.R" <Arif.Khan@ptcl.net.pk>
Cc:     Arif.Khan@ptcl.net.pk
Date:   Thu, 07 Dec 2023 07:15:00 -0800
Reply-To: chris-rhodes@cpn.it
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,MSGID_FROM_MTA_HEADER,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        RCVD_IN_PSBL,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trust you are in good health? I have emailed you earlier without a reply from yo!u.
Kindly reply for more briefing.

Thank!s
Chris R h o d e s
